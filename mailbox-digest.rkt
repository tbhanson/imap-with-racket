#lang racket

(require
  "imap-email-account-credentials.rkt"
  "connect-to-imap-account.rkt"
  net/imap
  "main-mail-header-parts.rkt"
  gregor
  racket/serialize
  )

(define (default-digest-folder-path)
  (let ([digestFolderName ".myMailDigests"])
    (let ([digestFolderPath (build-path (find-system-path 'home-dir) digestFolderName)])
      digestFolderPath)))

(define (mail-digest-file-name mailbox-digest)
  (let ([file-name ; make a name with datetime, e-mail address, and folder name
         (format "mailbox-digest_~a_~a_~a.ser"
                 (~t 
                  (mailbox-digest-timestamp mailbox-digest)
                  "yyyy-MM-dd_HH:mm:ss")
                 (mailbox-digest-mail-address mailbox-digest)
                 (mailbox-digest-folder-name mailbox-digest))])
    (let ([full-file-path
           (build-path (default-digest-folder-path) file-name)])
      full-file-path)))

(struct mailbox-digest
  (mail-address folder-name uid-validity index-range mail-headers timestamp)
  #:prefab
  )

; 
(provide
 (contract-out
  ; struct automatics
  [mailbox-digest (-> string? string? integer? pair? list? datetime? mailbox-digest?)]
  [mailbox-digest? (-> any/c boolean?)]
  [mailbox-digest-mail-address (-> mailbox-digest? string?)]
  [mailbox-digest-folder-name (-> mailbox-digest? string?)]
  [mailbox-digest-uid-validity (-> mailbox-digest? integer?)]
  [mailbox-digest-index-range (-> mailbox-digest? pair?)]
  [mailbox-digest-mail-headers (-> mailbox-digest? list?)]
  [mailbox-digest-timestamp (-> mailbox-digest? datetime?)]

  ;
  [get-mailbox-digest (-> imap-email-account-credentials? string? pair? mailbox-digest?)]
  [save-mailbox-digest (-> mailbox-digest? path?)]
  [load-mailbox-digest-from-file (-> path? mailbox-digest?)]
 ))

; 
(define (get-mailbox-digest mail-account-credential folder-name item-index-range)
  (let ([imap-conn
         (securely-connect-to-imap-account mail-account-credential folder-name)]
        [now-timestamp (now)])
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
                   '(uid header flags)))]) ; think about whether we also need flags
            (mailbox-digest
             (imap-email-account-credentials-mailaddress mail-account-credential)
             folder-name
             uid-validity
             item-index-range
             range-of-message-headers
             now-timestamp)))))))

; save serialized form of a mailbox-digest as a snapshot, return full path of file name
(define (save-mailbox-digest mailbox-digest)
  (let ([full-file-path
         (mail-digest-file-name mailbox-digest)])
    (let ([out (open-output-file full-file-path)])
      (write (serialize mailbox-digest) out)
      (close-output-port out))
    full-file-path))

(define (load-mailbox-digest-from-file digest-file-path)
  (let ([in (open-input-file digest-file-path)])
    (deserialize (read in))))
  
                 