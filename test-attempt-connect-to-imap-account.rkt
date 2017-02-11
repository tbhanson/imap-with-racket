#lang racket

(require rackunit
         "imap-email-account-credentials.rkt"
         "attempt-connect-to-imap-account.rkt")

; second attempt after getting some clues
;   https://groups.google.com/forum/m/?hl=en#!topic/racket-users/hpwQTdDoMlw
; and from looking at part of sirmail

(let ((iniFileName ".myImapCreds"))
  (let ((iniFilePath (build-path (find-system-path 'home-dir) iniFileName)))
    (check-equal?
     (file-exists? iniFilePath)
     #t)
    (let ((creds_hash (read-email-account-credentials-hash iniFilePath)))
      (let ((test_data
             (list
              ;(list "some account name in iniFile" "INBOX" ) ; --> imap-connect: username or password rejected by server: (NO authentication failed)
              ;(list "a gmail accountname" 993 "INBOX"  #t #f) ; --> imap-connect: username or password rejected by server: (NO |[ALERT]| Please log in via your web browser: https://support.google.com/mail/accounts/answer/78754 (Failure))

              ;(list "some other account name in iniFile" "INBOX") ; --> attempted (secure) imap-connection to ... at mail.tigertech.net; imap-connection? says #t
              ;(list "yet other account name in iniFile" "INBOX") ; --> attempted (secure) imap-connection to ... at posteo.de; imap-connection? says #t
              )))
        
        (for ([test-item test_data])
          (printf "test-item: ~a~n" test-item)
          (let ((test-acct-name (car test-item))
                (test-folder (cadr test-item)))
            (check-equal?
             (hash-has-key? creds_hash test-acct-name)
             #t)
            (let ((test-acct (hash-ref creds_hash test-acct-name)))
              (attempt-secure-connect-to-imap-account test-acct test-folder)
              )))))))


; original attempt, works so far some servers, not others
(let ((iniFileName ".myImapCreds"))
  (let ((iniFilePath (build-path (find-system-path 'home-dir) iniFileName)))
    (check-equal?
     (file-exists? iniFilePath)
     #t)
    (let ((creds_hash (read-email-account-credentials-hash iniFilePath)))
      (let ((test_data
             (list
              ;(list "account name in iniFile" 993 "INBOX"  #t #f) ; --> imap-connect: username or password rejected by server: (NO authentication failed)
              ;(list "account name in iniFile" 993 "INBOX"  #f #t) ; tcp-read: error reading system error: Connection reset by peer; errno=54

              ;(list "a gmail accountname" 993 "INBOX"  #t #f) ; --> imap-connect: username or password rejected by server: (NO |[ALERT]| Please log in via your web browser: https://support.google.com/mail/accounts/answer/78754 (Failure))
              )))
        
        (for ([test-item test_data])
          (printf "test-item: ~a~n" test-item)
          (let ((test-acct-name (car test-item))
                (test-port (cadr test-item))
                (test-folder (caddr test-item))
                (test-tls-before? (cadddr test-item))
                (test-try-tls? (first (cddddr test-item))))
            (check-equal?
             (hash-has-key? creds_hash test-acct-name)
             #t)
            (let ((test-acct (hash-ref creds_hash test-acct-name)))
              (attempt-connect-to-imap-account test-acct test-port test-folder test-tls-before? test-try-tls?)
              )))))))

