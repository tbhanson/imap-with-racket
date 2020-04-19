#lang racket

(require rackunit
         "imap-email-account-credentials.rkt")

; test default imap ini file function (to test more would make assumptions about user)
(check-equal?
 (path? (default-ini-filepath))
 #t)

; test one account, struct-provided basics
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
  (let ((test2 (read-one-email-account-credential
                (open-input-string account-credentials-as-string))))
    (check-equal? (imap-email-account-credentials? test2) #t)
    (check-equal? (imap-email-account-credentials-accountname test2) "an account")
    (check-equal? (imap-email-account-credentials-mailaddress test2) "me@some.where.net")
    ))

; test reading one account from a file
(check-equal?
 (imap-email-account-credentials? (read-one-email-account-credentials-from-file-named "test-data/one-test-imap-email-account-credentials.rkt"))
 #t)

(let ([filename-containing-two-accounts "test-data/list-of-test-imap-email-account-credentials.rkt"])
  (begin
    ; test reading a list of two accounts from a file containing two such
    (check-equal?
     (map
      imap-email-account-credentials?
      (read (open-input-string (file->string filename-containing-two-accounts))))
     '(#t #t))

    ; test reading a hash of credentials from  a file containing two such
    (let ([test-cred-hash (read-email-account-credentials-hash-from-file-named filename-containing-two-accounts)])
      (begin
        ; test reading a list of two accounts into a hash of accounts
        (check-equal?
         (hash-has-key?
          test-cred-hash
          "an account")
         #t)
        
        (check-equal?
         (hash-has-key?
          test-cred-hash
          "foobar")
         #f)))))
