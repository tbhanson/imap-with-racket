#lang racket

; work in progress

(require rackunit
         rackunit/text-ui
         racket/serialize

         "mailbox-digest.rkt"
         "imap-email-account-credentials.rkt"
;         "main-mail-header-parts.rkt"
         )



(run-tests
 (test-suite
  "get-mailbox-digest"
  (let ([iniFilePath (default-ini-filepath)])
    (let ([creds_hash (read-email-account-credentials-hash-from-file-named iniFilePath)]
          [folder-name "INBOX"]
          [test-acct-name "tbhanson gmx"]) ;"tim at w-h"
      (let ([mail-account-credential (hash-ref creds_hash test-acct-name)]
            [msg-count-to-examine 10000])
        (let ([msg-index-range (cons 1 msg-count-to-examine)])
          (let ([under-test
                 (time
                  (get-mailbox-digest mail-account-credential folder-name msg-index-range))])
            ; redundant because of contracts
            (check-equal?
             (mailbox-digest? under-test)
             #t)
            (let ([digest-file-path
                   (time (save-mailbox-digest under-test))])
              (let ([clone-we-hope
                     (time (load-mailbox-digest-from-file digest-file-path))])
                (check-equal?
                 (mailbox-digest? clone-we-hope)
                 #t)
                )))))))))
                
              
