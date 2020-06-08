#lang racket

; work in progress

(require "imap-email-account-credentials.rkt"
         "range-of-messages.rkt"
         "main-mail-header-parts.rkt"
         )

(provide
 (contract-out
  [gather-message-headers (-> string? string? integer? (and/c pair? list?))]
  ))

; think about how to (partially) mirror mail headers from servers to local
; 
; connect to server, retrieve messages, extract message headers
; e.g. (gather-message-headers "tbhanson gmx" "INBOX" 10)
(define (gather-message-headers account-name folder-name msg-count-to-examine)
  (let ([iniFilePath (default-ini-filepath)])
    (let* ([creds_hash (read-email-account-credentials-hash-from-file-named iniFilePath)]
           [email-account-credential (hash-ref creds_hash account-name)])
      (let ([under-test
             (time
              (get-range-of-messages email-account-credential folder-name (cons 1 msg-count-to-examine))
              )])
        ; now let's convert these using mail-header->main-mail-header-parts and save only these parts we care about
        (let ([headers-only
               (time
                (map mail-header->main-mail-header-parts under-test))])
          headers-only)))))


; e.g. (collect-mail-headers "tbhanson gmx" "INBOX" 10 "~/mail-header-data")
;(define (gather-message-headers account-name folder-name msg-count-to-examine output-folder-name)
