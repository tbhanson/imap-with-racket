#lang racket

; work in progress

(require rackunit
         rackunit/text-ui
         racket/serialize

         "mailbox-digest.rkt"
         "imap-email-account-credentials.rkt"
         "range-of-messages.rkt"
         "main-mail-header-parts.rkt"
         )

; connect to server, retrieve messages, extract message header
; e.g. (collect-mail-headers "tbhanson gmx" "INBOX" 10 "~/mail-header-data")
(define (collect-mail-headers account-name folder-name msg-count-to-examine output-folder-name)
  (let ([iniFilePath (default-ini-filepath)])
    (let* ([creds_hash (read-email-account-credentials-hash-from-file-named iniFilePath)]
           [email-account-credential (hash-ref creds_hash account-name)])
      (let ([under-test
             (time
              (get-range-of-messages email-account-credential folder-name (cons 1 msg-count-to-examine))
              )])
        (check-equal?
         (length under-test)
         msg-count-to-examine)
        ; now let's convert these using mail-header->main-mail-header-parts and save only these parts we care about
        (let ([headers-only
               (time
                (map mail-header->main-mail-header-parts under-test))])
          (time
           (for ([one-header headers-only])
             (printf "one-header: ~a~n" one-header)
             ;               (let ([ser (serialize under-test)])
             ;               (print ser)
             ))))))
  )


(run-tests
 (test-suite
  "mailbox-digest"
  ))
  
