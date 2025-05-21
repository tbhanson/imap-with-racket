#lang racket

; 2025-05-21
; finally get around to trying;
; not working yet
;
; 2025-04-10 
; cf (for now, and some days later, 2025-04-10, this explanation is still available:
;; Transferring Video Files Between Mac and Windows - Claude
;; https://claude.ai/chat/210eee98-98f9-429e-a3c4-8dbdd8864a89
;; ), but I think I will record it here as a doc of sorts.


; Required libraries
(require net/imap
         json
         net/url
         openssl
         racket/port
         web-server/servlet
         web-server/servlet-env)

(require net/uri-codec
         net/imap)

; You'll need to set up a Google Cloud Project and obtain these credentials
(define CLIENT-ID "748346858749-g6pvdo2aohlqc8qclof4qkbosqbf1tig.apps.googleusercontent.com")
(define CLIENT-SECRET "(secret)")
(define REDIRECT-URI "http://localhost:8080")
(define PORT 8080)

; Global variable to store the authorization code
(define auth-code-promise (make-channel))

; Simple web server to catch the OAuth redirect
(define (start-auth-server)
  (define (request-handler request)
    ; Extract the authorization code from the query parameters
    (define uri (request-uri request))
    (when (url-query uri)
      (for ([binding (url-query uri)])
        (when (and (pair? binding) (eq? (car binding) 'code))
          (channel-put auth-code-promise (cdr binding)))))
    
    ; Send a response to the browser
    (response/xexpr
     `(html
       (head (title "Authentication Complete"))
       (body
        (h1 "Authentication Complete")
        (p "You can now close this window and return to your application.")))))
  
  ; Start the web server
  (printf "Starting local web server on port ~a to receive OAuth callback...\n" PORT)
  (thread 
   (lambda () 
     (serve/servlet request-handler
                    #:listen-ip "127.0.0.1"
                    #:port PORT
                    #:servlet-path "/"
                    #:servlet-regexp #rx""))))

; OAuth 2.0 Authorization URL
(define (get-authorization-url)
  (string-append
   "https://accounts.google.com/o/oauth2/v2/auth?"
   "client_id=" CLIENT-ID
   "&redirect_uri=" (uri-encode REDIRECT-URI)
   "&response_type=code"
   "&scope=https://mail.google.com/"
   "&access_type=offline"))

; Function to exchange authorization code for access token
(define (get-access-token auth-code)
  (let* ([token-url "https://oauth2.googleapis.com/token"]
         [post-data 
          (string-append 
           "client_id=" CLIENT-ID
           "&client_secret=" CLIENT-SECRET
           "&code=" auth-code
           "&grant_type=authorization_code"
           "&redirect_uri=" (uri-encode REDIRECT-URI))]
         [in (open-input-string post-data)]
         [response 
          (post-pure-port 
           (string->url token-url)
           (list 
            "Content-Type: application/x-www-form-urlencoded")
           in)])
    (with-handlers 
      ([exn:fail? 
        (lambda (exn)
          (printf "Error getting access token: ~a\n" 
                  (exn-message exn))
          #f)])
      (let* ([response-json (read-json response)]
             [access-token (hash-ref response-json 'access_token #f)]
             [refresh-token (hash-ref response-json 'refresh_token #f)])
        (if access-token
            (values access-token refresh-token)
            (begin
              (printf "Failed to get access token. Response: ~s\n" response-json)
              (values #f #f)))))))

; IMAP connection function with OAuth
(define (connect-to-gmail username access-token)
  (printf "Connecting to Gmail IMAP server...\n")
  (let ([imap-connection 
         (imap-connect 
          "imap.gmail.com" 
          993 
          #t  ; use SSL
          (lambda (user password)
            ; Use XOAUTH2 authentication method
            (string-append 
             "user=" username 
             "\1auth=Bearer " access-token 
             "\1\1")))])
    (printf "IMAP connection established.\n")
    imap-connection))

; Main authentication workflow
(define (authenticate-gmail username)
  ; Start local web server to receive the redirect
  (start-auth-server)
  
  ; Generate and display authorization URL
  (printf "1. Open this URL in your browser:\n~a\n" 
          (get-authorization-url))
  (printf "2. Authorize the application\n")
  (printf "Waiting for authorization...\n")
  
  ; Wait for the authorization code from the web server
  (define auth-code (channel-get auth-code-promise))
  (printf "Authorization code received!\n")
  
  ; Exchange the code for tokens
  (let-values ([(access-token refresh-token) (get-access-token auth-code)])
    (if access-token
        (begin
          (printf "Successfully obtained access token.\n")
          (when refresh-token
            (printf "Refresh token received. You can save this for future use: ~a\n" refresh-token))
          ; Connect to Gmail with the access token
          (connect-to-gmail username access-token))
        (begin
          (printf "Authentication failed.\n")
          #f))))

; Example usage
(define (main)
  (printf "Enter your Gmail address: ")
  (define gmail-address (read-line))
  (let ([gmail-connection (authenticate-gmail gmail-address)])
    ; Additional IMAP operations would go here
    (when gmail-connection
      ; Example: List mailboxes
      (printf "Listing mailboxes:\n")
      (for ([mailbox (imap-list-child-mailboxes gmail-connection)])
        (printf "- ~a\n" mailbox))
      
      ; Disconnect when done
      (imap-disconnect gmail-connection)
      (printf "Disconnected from Gmail IMAP server.\n"))))

; Uncomment to run
;(main)