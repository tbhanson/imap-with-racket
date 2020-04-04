#lang racket

(require rackunit
         "imap-email-account-credentials.rkt")

; test one account, some basics
(let ((some-accountname "my account")
      (some-host "some.host.net")
      (some-address "fred@somewhere.org")
      (some-pwd "fred's password"))
  (let ((test1 (imap-email-account-credentials some-accountname some-host some-address some-pwd)))
    (check-equal? (imap-email-account-credentials? test1) #t)
    (check-equal? (imap-email-account-credentials-accountname test1) some-accountname)
    (check-equal? (imap-email-account-credentials-hostname test1) some-host)
    (check-equal? (imap-email-account-credentials-mailaddress test1) some-address)
    (check-equal? (imap-email-account-credentials-password test1) some-pwd)
     ))

; test reading one account from a string
; https://docs.racket-lang.org/guide/serialization.html#%28tech._serialization%29
;
(let ((account-credentials-as-string "#s(imap-email-account-credentials \"an account\" \"ahost.com\" \"me@some.where.net\" \"secret stuff\")"))
  (let ((test2 (read-email-account-credentials
                (open-input-string account-credentials-as-string))))
    (check-equal? (imap-email-account-credentials? test2) #t)
    (check-equal? (imap-email-account-credentials-accountname test2) "an account")))

; test reading one account from a file
(check-equal?
 (imap-email-account-credentials? (read-email-account-credentials-from-file "test-data/one-test-imap-email-account-credentials.rkt"))
 #t)

(define filename-containing-two-accounts "test-data/list-of-test-imap-email-account-credentials.rkt")

; test reading a list of two accounts from another file
(check-equal?
 (map imap-email-account-credentials? (read (open-input-file filename-containing-two-accounts)))
 '(#t #t))


; test reading a list of two accounts into a hash of accounts
(check-equal?
 (hash-has-key?
  (read-email-account-credentials-hash-from-port filename-containing-two-accounts)
  "an account")
 #t)

(check-equal?
 (hash-has-key?
  (read-email-account-credentials-hash-from-port filename-containing-two-accounts)
  "foobar")
 #f)
