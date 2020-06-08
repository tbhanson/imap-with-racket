#lang racket

; work in progress

(require rackunit
         rackunit/text-ui
         racket/serialize

         "gather-message-headers.rkt"
         )


(run-tests
 (test-suite
  "gather-message-headers"
  (let ([msg-count-to-examine 3])
    (let ([under-test (gather-message-headers "tbhanson gmx" "INBOX" msg-count-to-examine)])
      (check-equal?
       (length under-test)
       msg-count-to-examine)
      (printf "under-test: ~a~n"
              (pretty-format under-test))
      (let ([ser (serialize under-test)])
        (printf "serialized: ~a~n" ser)
        
      )))
  ))
  
