#lang racket

; cf (for now, and some days later, 2025-04-10, this explanation is still available:
;; Transferring Video Files Between Mac and Windows - Claude
;; https://claude.ai/chat/210eee98-98f9-429e-a3c4-8dbdd8864a89
;; ), but I think I will record it here as a doc of sorts.


; Required libraries
(require net/imap
         json
         net/url
         openssl
         racket/port)

; You'll need to set up a Google Cloud Project and obtain these credentials
(define CLIENT-ID "your-google-cloud-client-id")
(define CLIENT-SECRET "your-google-cloud-client-secret")
(define REDIRECT-URI "urn:ietf:wg:oauth:2.0:oob")

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
             [access-token (hash-ref response-json 'access_token)]
             [refresh-token (hash-ref response-json 'refresh_token #f)])
        (values access-token refresh-token)))))

; IMAP connection function with OAuth
(define (connect-to-gmail access-token)
  (let ([imap-connection 
         (imap-connect 
          "imap.gmail.com" 
          993 
          #t  ; use SSL
          (lambda (username password)
            ; Use XOAUTH2 authentication method
            (string-append 
             "user=" username 
             "\1auth=Bearer " access-token 
             "\1\1")))])
    imap-connection))

; Main authentication workflow
(define (authenticate-gmail)
  (printf "1. Open this URL in your browser:\n~a\n" 
          (get-authorization-url))
  (printf "2. Authorize the application and copy the authorization code\n")
  (printf "Enter the authorization code: ")
  (let* ([auth-code (read-line)]
         [tokens (get-access-token (string-trim auth-code))])
    (if tokens
        (let-values ([(access-token refresh-token) tokens])
          (printf "Successfully obtained access token\n")
          ; Here you would typically save refresh-token for future use
          (connect-to-gmail access-token))
        (printf "Authentication failed\n"))))

; Example usage
(define (main)
  (let ([gmail-connection (authenticate-gmail)])
    ; Additional IMAP operations would go here
    (when gmail-connection
      (imap-disconnect gmail-connection))))

; Uncomment to run
; (main)