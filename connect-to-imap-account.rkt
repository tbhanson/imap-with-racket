#lang racket

(require openssl)
(require net/imap)
(require net/head)
(require "imap-email-account-credentials.rkt")

(provide
 securely-connect-to-imap-account
 collect-some-imap-account-stats
 )
 

(define (securely-connect-to-imap-account one-imap-email-account-credential mail-folder)
  (let ((port-no 993)
        (hostname (imap-email-account-credentials-hostname one-imap-email-account-credential))
        (mailaddress (imap-email-account-credentials-mailaddress one-imap-email-account-credential))
        (password (imap-email-account-credentials-password one-imap-email-account-credential)))

    (let-values
        ([(imap-connection messages# nu)
          (let-values ([(in out) (ssl-connect hostname port-no)])
            (imap-connect* in out mailaddress password mail-folder))]) ; also tried with #:tls? for gmail, but no cigar (it needs OAuthId o.ä., I later learned)
      (begin
        (printf "attempted (secure) imap-connection to ~a at ~a; imap-connection? says ~a; messages#: ~a; nu: ~a~n"
                mailaddress
                hostname
                (imap-connection? imap-connection)
                messages#
                nu
                )

        ; to learn more about how to use the various functions, don't close the connection but return it instead, so we can interact with it
        ;(imap-disconnect imap-connection)
        imap-connection))))


(define (assert pred anError)
  (if (not pred) 
      (raise anError)
      #t))

; return hash of hashes:
; - outer key header-field 
; - inner hash is counts by value found in header-field
(define (collect-some-imap-account-stats email-account-credential mail-folder item-index-range header-fields)
  (assert (and (pair? item-index-range)
               (integer? (car item-index-range))
               (integer? (cdr item-index-range))
               (<= 1 (car item-index-range))
               (<= (car item-index-range)) (cdr item-index-range))
          (format "we need item-index-range to be a pair of non-negative integers (a,b) with a <= b. you sent ~a~n" item-index-range))
               
  (let ([imap-conn
         (securely-connect-to-imap-account email-account-credential mail-folder)])
    (let ([msg-count (imap-messages imap-conn)]
          [lo-index (car item-index-range)])
      (let ([hi-index (min msg-count (cdr item-index-range))])
        (begin
          (printf "there are ~a messages in folder ~a of account ~a~n" msg-count mail-folder (imap-email-account-credentials-accountname email-account-credential))
          (assert (<= lo-index msg-count) (format "autschn! lo-index ~a is larger than msg-count ~a~n" lo-index msg-count))
          (printf "we will look at those indexed ~a to ~a~n" lo-index hi-index)
          (let ([range-of-messages (imap-get-messages imap-conn (stream->list (in-range lo-index (+ hi-index 1))) '(header))])
            (for/fold ([result (make-immutable-hash)])
                      ([field header-fields])
              (values (hash-set
                       result
                       field 
                       (for/fold ([counts-by-field-value (make-immutable-hash)])
                                 ([msg range-of-messages]
                                  [idx (in-range lo-index (+ hi-index 1))])
                         (let ([header (first msg)])
                           (let ([field-contents (bytes->string/utf-8 (extract-field field header))])
                             (begin
                               (printf "idx: ~a~n" idx)
                               (printf "  counts-by-field-value: ~a~n" counts-by-field-value)
                               (printf "  field-contents: ~a~n" field-contents)
                               (printf "  (date? field-contents): ~a~n" (date? field-contents))
                               (printf "  (string? field-contents): ~a~n" (string? field-contents))
                               (values (hash-update counts-by-field-value field-contents (lambda (n) (+ n 1)) 0))))))
                       )))))))))
