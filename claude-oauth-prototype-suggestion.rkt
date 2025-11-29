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
(define (get-authorization-url client-id)
  (string-append
   "https://accounts.google.com/o/oauth2/v2/auth?"
   "client_id=" client-id
   "&redirect_uri=" (uri-encode REDIRECT-URI)
   "&response_type=code"
   "&scope=https://mail.google.com/"
   "&access_type=offline"))

; Function to exchange authorization code for access token
(define (get-access-token auth-code client-id client-secret)
  (let* ([token-url "https://oauth2.googleapis.com/token"]
         [post-data 
          (string-append 
           "client_id=" client-id
           "&client_secret=" client-secret
           "&code=" auth-code
           "&grant_type=authorization_code"
           "&redirect_uri=" (uri-encode REDIRECT-URI))]
         [in (open-input-string post-data)]
         [response 
          (post-pure-port 
           (string->url token-url)
           (string->bytes/utf-8 post-data)
           (list 
            "Content-Type: application/x-www-form-urlencoded")
           )
          ])
    (with-handlers 
      ([exn:fail? 
        (lambda (exn)
          (printf "Error getting access token: ~a\n" 
                  (exn-message exn))
          #f)])
      (begin
        (let ([response-json (read-json response)])
          (printf "response-json: ~a~n" response-json)
          (let ([access-token (hash-ref response-json 'access_token #f)]
                [refresh-token (hash-ref response-json 'refresh_token #f)]
                [expires-in (hash-ref response-json 'expires_in #f)]
                [scope (hash-ref response-json 'scope #f)]
                [token-type (hash-ref response-json 'token_type #f)])
                
            (printf "access-token: ~a~n" access-token)
            (printf "refresh-token: ~a~n" refresh-token)
            (printf "expires-in: ~a~n" expires-in)
            (printf "scope: ~a~n" scope)
            (printf "token-type: ~a~n" token-type)

            (if access-token
                (values access-token refresh-token)
                (begin
                  (printf "Failed to get access token. Response: ~s\n" response-json)
                  (values #f #f)))))))))

; IMAP connection function with OAuth
(define (connect-to-gmail username access-token)
  (let ([port-no 993]
        [hostname  "imap.gmail.com"])
    (printf "Connecting to Gmail IMAP server...\n")
    (let-values
        ([(imap-connection messages# nu)
          (let-values ([(in out) (ssl-connect hostname port-no)])
            (imap-connect*
             in
             out
             username
             access-token
             "INBOX"
             ;;#:tls? #t
             #:try-tls? #t
             #:xoauth2? #t
             ))])

      (printf "Connecting to Gmail IMAP server...\n")
      (printf "IMAP connection established.\n")
      imap-connection)))

; Main authentication workflow
(define (authenticate-gmail username client-id client-secret)

  ; Start local web server to receive the redirect
  (start-auth-server)

  ; Generate and display authorization URL
  (printf "1. Open this URL in your browser:\n~a\n" 
          (get-authorization-url client-id))
  (printf "2. Authorize the application\n")
  (printf "Waiting for authorization...\n")
  
  ; Wait for the authorization code from the web server
  (define auth-code (channel-get auth-code-promise))
  (printf "Authorization code received!\n")
  
  ; Exchange the code for tokens
  (let-values ([(access-token refresh-token) (get-access-token auth-code client-id client-secret)])
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
  (printf "Enter client ID ")
  (define client-id (read-line))
  ; get client secret (how long do these last?!)
  (printf "Enter client secret: ")
  (define client-secret (read-line))

  
  (let ([gmail-connection (authenticate-gmail gmail-address client-id client-secret)])
    ; Additional IMAP operations would go here
    (when gmail-connection
      ; Example: List mailboxes
      (printf "Listing mailboxes:\n")
      (for ([mailbox (imap-list-child-mailboxes gmail-connection #f)])
        (printf "- ~a\n" mailbox))
      
      ; Disconnect when done
      (imap-disconnect gmail-connection)
      (printf "Disconnected from Gmail IMAP server.\n"))))

; Uncomment to run
;(main)