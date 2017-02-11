#lang racket

(require openssl)
(require net/imap)
(require "imap-email-account-credentials.rkt")

(provide
 attempt-secure-connect-to-imap-account
 attempt-connect-to-imap-account)
 

(define (attempt-secure-connect-to-imap-account one-imap-email-account-credential  folder)
  (let ((port-no 993)
        (hostname (imap-email-account-credentials-hostname one-imap-email-account-credential))
        (mailaddress (imap-email-account-credentials-mailaddress one-imap-email-account-credential))
        (password (imap-email-account-credentials-password one-imap-email-account-credential)))

    (let-values
        ([(imap-connection messages# nu)
          (let-values ([(in out) (ssl-connect hostname port-no)])
            (imap-connect* in out mailaddress password folder))]) ; also tried with #:tls? for gmail, but no cigar

      (printf "attempted (secure) imap-connection to ~a at ~a; imap-connection? says ~a~n"
              mailaddress
              hostname
              (imap-connection? imap-connection)))))


(define (attempt-connect-to-imap-account one-imap-email-account-credential port folder tls-before? try-tls?)
  (let
      ((hostname (imap-email-account-credentials-hostname one-imap-email-account-credential))
       (mailaddress (imap-email-account-credentials-mailaddress one-imap-email-account-credential))
       (password (imap-email-account-credentials-password one-imap-email-account-credential)))

    (let-values
        ([(imap-connection messages# nu)
          (parameterize ([imap-port-number port])
                       (imap-connect hostname mailaddress password folder #:tls? tls-before? #:try-tls? try-tls?))])
      (printf "attempted imap-connection to ~a at ~a; imap-connection? says ~a~n"
              mailaddress
              hostname
              (imap-connection? imap-connection)))))
