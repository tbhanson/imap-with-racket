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
