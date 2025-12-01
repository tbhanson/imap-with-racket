#lang racket

(require rackunit
         "oauth2-details.rkt")

; what to test?
; basics:
; - that we can create and query one of these objects
; i/o:
; - that we can save these details into a file
; - that its permissions are read/write only by owner
; - that we can read it back in and get what we had
; (clean up after test)


;; (let ([client-id "random"]
;;       [client-secret "hushhush"]
;;       [redirect-uri "http://somewhere.else"])
;;   (let ([test-oauth2-details (oauth2-details client-id client-secret redirect-uri)])
;;     (printf "test: ~a~n" test-oauth2-details)))


(let ([oauth2-details-as-string "#s(oauth2-details \"a client id\" \"a client secret\" \"a redirect uri\")"])
  (let ([test-oauth2-details
         (read-oauth2-details
          (open-input-string oauth2-details-as-string))])
    (check-true (oauth2-details? test-oauth2-details))
    (check-equal? (oauth2-details-client-id test-oauth2-details) "a client id")
    (check-equal? (oauth2-details-client-secret test-oauth2-details) "a client secret")
    (check-equal? (oauth2-details-redirect-uri test-oauth2-details) "a redirect uri")
    ))

; test reading one oauth2-details from a file
(check-true
 (oauth2-details? (read-one-oauth2-details-from-file-named "test-data/one-test-oauth2-details.rkt")))

; test writing one oauth2-details to a file
(let ([test-email-address "fakey@phoney.org"]
      [client-id "fake client id"]
      [client-secret "fake client secret"]
      [redirect-url "fake redirect-url"])
  (let ([write-to-file-path (oauth2-details-filepath-from-dir (build-path (current-directory) "test-data") test-email-address)]
        [test-oauth2-details (oauth2-details client-id client-secret redirect-url)])
    (begin
      (check-true
       (string-contains? (path->string write-to-file-path) "test-data"))
      (check-true
       (string-suffix? (path->string write-to-file-path) test-email-address))
      
      (printf "write-to-file-path: ~a~n" write-to-file-path)

      ; check before
      (check-false
       (file-exists? write-to-file-path)
       (format "test file we want to write (~a) unexpectedly exists" write-to-file-path))

      ; function we test
      (write-oauth2-details-to-file test-oauth2-details write-to-file-path)

      ; check after
      (check-true
       (file-exists? write-to-file-path)
       (format "test file we wanted to write (~a) unexpectedly does NOT exist" write-to-file-path))

      ; clean up
      (delete-file write-to-file-path)
      
      
;;       
;;       (let ([test-output-file
;;              (open-output-file 
      )))


      
  


