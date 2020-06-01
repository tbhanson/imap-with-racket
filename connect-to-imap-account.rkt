#lang racket

(require openssl)
(require net/imap)
(require net/head)
(require "imap-email-account-credentials.rkt")

(provide
 securely-connect-to-imap-account
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


