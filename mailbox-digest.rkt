#lang racket

(require
  "imap-email-account-credentials.rkt"
  "connect-to-imap-account.rkt"
  net/imap
  "main-mail-header-parts.rkt"
  )

(struct mailbox-digest
  (mail-address folder-name uid-validity index-range mail-headers)
  #:prefab
  )

; 
(provide
 (contract-out
  ; struct automatics
  [mailbox-digest (-> string? string? integer? pair? list? mailbox-digest?)]
  [mailbox-digest? (-> any/c boolean?)]
  [mailbox-digest-mail-address (-> mailbox-digest? string?)]
  [mailbox-digest-folder-name (-> mailbox-digest? string?)]
  [mailbox-digest-uid-validity (-> mailbox-digest? integer?)]
  [mailbox-digest-index-range (-> mailbox-digest? pair?)]
  [mailbox-digest-mail-headers (-> mailbox-digest? list?)]

  ;
  [get-mailbox-digest (-> imap-email-account-credentials? string? pair? mailbox-digest?)]

 ))

; 
(define (get-mailbox-digest mail-account-credential folder-name item-index-range)
  (let ([imap-conn
         (securely-connect-to-imap-account mail-account-credential folder-name)])
    (let ([msg-count (imap-messages imap-conn)]
          [uid-validity (imap-uidvalidity imap-conn)]
          [lo-index (car item-index-range)])
      (let ([hi-index (min msg-count (cdr item-index-range))])
        (begin
          (printf "there are ~a messages in folder ~a of account ~a~n" msg-count folder-name (imap-email-account-credentials-accountname mail-account-credential))
          (printf "we will look at those indexed ~a to ~a~n" lo-index hi-index)
          (let ([range-of-message-headers
                 (map
                  mail-header->main-mail-header-parts
                  (imap-get-messages
                   imap-conn
                   (stream->list (in-range lo-index (+ hi-index 1)))
                   '(uid header)))]) ; think about whether we also need flags
            (mailbox-digest
             (imap-email-account-credentials-mailaddress mail-account-credential)
             folder-name
             uid-validity
             item-index-range
             range-of-message-headers)))))))