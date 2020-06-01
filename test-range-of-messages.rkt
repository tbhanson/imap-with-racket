#lang racket

(require rackunit
         rackunit/text-ui

         "imap-email-account-credentials.rkt"

         "range-of-messages.rkt"
          ;racket/serialize
         )



(run-tests
  (test-suite
   "mailbox-digest"

   (let ([iniFilePath (default-ini-filepath)])
     (let ([creds_hash (read-email-account-credentials-hash-from-file-named iniFilePath)]
           [mail-folder "INBOX"])
       (for ([test-acct-name (list "tbhanson gmx" ;"tim at w-h"
                                   )])
         (let ([email-account-credential (hash-ref creds_hash test-acct-name)]
               [msg-count-to-examine 1])
           (let ([under-test
                  (time
                   (get-range-of-messages email-account-credential mail-folder (cons 1 msg-count-to-examine))
                   )])
             ;(printf "under-test: ~a~n" under-test)
             (check-equal?
              (length under-test)
              msg-count-to-examine)
             ;(printf "(serialize (car under-test)): ~a~n" (serialize (car under-test)))
             ;(with-output-to-file "test-data/try-one.rkt"
             ;  (lambda () (write (serialize (car under-test)))))
             
             )))))))