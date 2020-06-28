#lang racket

; work in progress

(require rackunit
         rackunit/text-ui
         racket/serialize

         "mailbox-digest.rkt"
         "imap-email-account-credentials.rkt"
         )


; to do:
; - anonymize a small sample
; - add to test data
; - replace this test with one or two that don't need to go online at all 
;

(run-tests
 (test-suite
  "all"
  
;  (test-suite
;   "get-mailbox-digest"
;   (let ([iniFilePath (default-ini-filepath)])
;     (let ([creds_hash (read-email-account-credentials-hash-from-file-named iniFilePath)]
;           [folder-name "INBOX"]
;           [test-acct-name "tbhanson gmx"]) ;"tim at w-h"
;       (let ([mail-account-credential (hash-ref creds_hash test-acct-name)]
;             [msg-count-to-examine 10])
;         (let ([msg-index-range (cons 1 msg-count-to-examine)])
;           (let ([under-test
;                  (time
;                   (get-mailbox-digest mail-account-credential folder-name msg-index-range))])
;             (let ([digest-file-path
;                    (time (save-mailbox-digest under-test))])
;               (let ([clone-we-hope
;                      (time (load-mailbox-digest-from-file digest-file-path))])
;                 (check-equal?
;                  clone-we-hope
;                  under-test)
;                 ))))))))

  (test-suite
   "load-mailbox-digest-from-file and friends"
   (let ([digest-file-path
          (build-path (default-digest-folder-path) "mailbox-digest_2020-06-27_11:24:42_tbhanson@gmx.de_INBOX.ser")])
     (let ([a-mailbox-digest (load-mailbox-digest-from-file digest-file-path)])
       (check-equal?
        (mailbox-digest? a-mailbox-digest)
        #t)
       
       (check-equal?
        (mailbox-digest-count a-mailbox-digest)
        10)

       (let ([mail-digests-by-uid
              (mailbox-digest-mail-digests-by-uid a-mailbox-digest)])
         (check-equal?
          (hash-count mail-digests-by-uid)
          10)

         ;(printf "mail-digests-by-uid: ~a~n" (pretty-print mail-digests-by-uid))
         )

       (let ([mailids-by-from-addr
              (mailbox-digest-mailids-by-from-addr a-mailbox-digest)])
         (check-true
          (<= 
           (hash-count mailids-by-from-addr)
           10))

         ;(printf "mailids-by-from-addr: ~a~n" (pretty-print mailids-by-from-addr))
         )

       )))
        

  
  ) 
 )

