#lang racket

(require rackunit
         net/imap
         "imap-email-account-credentials.rkt"

         "connect-to-imap-account.rkt"
         "parse-date-time-string-statistics.rkt"
         "parse-to-address-statistics.rkt"
         )




  ; second attempt after getting some clues
  ;   https://groups.google.com/forum/m/?hl=en#!topic/racket-users/hpwQTdDoMlw
  ; and from looking at part of sirmail
  ; preliminaries:
  ; test with tim@..., one main target for cleaning up
  (let ([iniFilePath (default-ini-filepath)])
    (begin
      (check-equal?
       (path? iniFilePath)
       #t)
    
      (check-equal?
       (file-exists? iniFilePath)
       #t)
      (let ([creds_hash (read-email-account-credentials-hash-from-file-named iniFilePath)])
        (begin
          (check-equal?
           (hash-has-key? creds_hash "tim at w-h")
           #t)
        
          (let ([test_data
                 (list
                  (list "tim at w-h" "INBOX"))])
            (for ([test-item test_data])
              (printf "test-item: ~a~n" test-item)
              (let ([test-acct-name (car test-item)]
                    [test-folder (cadr test-item)])
                (begin
                  (check-equal?
                   (hash-has-key? creds_hash test-acct-name)
                   #t)
                  (let ([test-acct (hash-ref creds_hash test-acct-name)])
                    (let ([imap-conn
                           (securely-connect-to-imap-account test-acct test-folder)])
                      (begin
                        (check-equal?
                         (imap-connection? imap-conn)
                         #t)
                        (let ([msg-count (imap-messages imap-conn)])
                          (printf "msg-count: ~a~n" msg-count)))))))))))))
