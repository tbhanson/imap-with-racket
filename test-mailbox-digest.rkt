#lang racket

(require rackunit
         rackunit/text-ui

         "mailbox-digest.rkt"
         )

(run-tests
  (test-suite
   "mailbox-digest"

   (let ([iniFilePath (default-ini-filepath)])
     (let ([creds_hash (read-email-account-credentials-hash-from-file-named iniFilePath)])
       (for ([test-acct-name (list "tbhanson gmx" ;"tim at w-h"
                                   )])
         (let ([test-acct (hash-ref creds_hash test-acct-name)]
               [msg-count-to-examine 10])
           (let ([under-test
                  (time
                   (get-range-of-messages email-account-credential mail-folder (cons 1 msg-count-to-examine))
                   )])
             (check-equal?
              (length under-test)
              msg-count-to-examine))))))))
             