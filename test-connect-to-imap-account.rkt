#lang racket

(require rackunit
         "imap-email-account-credentials.rkt"
         "connect-to-imap-account.rkt")

(require net/imap)
(require net/head)




; compute some statistics for "INBOX" of account "tim at w-h"
; NB: when I upped the count examined from 10 to 100 the real time spent was 3+ seconds, up from 3- seconds
; when I upped it from 100 to 1000, time elapsed was about 4.4s
; however, at 1000 I noticed that stats on "to" are not very interesting: I get all the different combinations incuding various spellings of myself
; from is still interesting and I think the next project will be looking at date sent collapsed into year or year-month, I suspect
(let ([iniFilePath (default-ini-filepath)])
  (let ([creds_hash (read-email-account-credentials-hash-from-file-named iniFilePath)])
    (let ([test-acct (hash-ref creds_hash "tim at w-h")])
      (let ([fields (list #"to" #"from" #"date")]
            [msg-count-to-examine 10])
        (let ([under-test  (time (collect-some-imap-account-stats test-acct "INBOX" (cons 1 msg-count-to-examine) fields))])
          (begin
            (check-equal?
             (hash? under-test)
             #t)
            (check-equal?
             (hash-count under-test)
             (length fields))
            (for ([f fields])
              (check-equal?
               (hash-has-key? under-test f)
               #t))
            ; for each main key the sum of all counts in its hash must equal the number of messages we looked at
            (for ([f fields])
              (let ([sub-hash (hash-ref under-test f)])
                (check-equal?
                 (for/fold ([sum-counts 0])
                           ([key (hash-keys sub-hash)])
                   (values (+ sum-counts (hash-ref sub-hash key))))
                 msg-count-to-examine)))

            ; show what we have for now to help debug and understand
            (for ([key (hash-keys under-test)])
              (printf "under-test at ~a: ~a~n" key (hash-ref under-test key)))))))))
  
        
        

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
                ;(list "tim at w-h" "INBOX")
                ;(list "some account name in iniFile" "INBOX" ) ; --> imap-connect: username or password rejected by server: (NO authentication failed)
                ;(list "a gmail accountname" 993 "INBOX"  #t #f) ; --> imap-connect: username or password rejected by server: (NO |[ALERT]| Please log in via your web browser: https://support.google.com/mail/accounts/answer/78754 (Failure))
                
                ;(list "some other account name in iniFile" "INBOX") ; --> attempted (secure) imap-connection to ... at mail.tigertech.net; imap-connection? says #t
                ;(list "yet other account name in iniFile" "INBOX") ; --> attempted (secure) imap-connection to ... at posteo.de; imap-connection? says #t
                )])
          
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
                        (let ([first-N (min 5 msg-count)])
                          (begin
                            (printf "there are ~a messages in folder ~a of account ~a~n" msg-count test-folder test-acct-name)
                            (printf "we will look at the first ~a of them~n" first-N)
                            (let ([first-N-messages (imap-get-messages imap-conn (stream->list (in-range 1 first-N)) '(uid header body flags))])
                              (begin
                                (for ([s first-N-messages])
                                  (let ([uid (first s)]
                                        [header (second s)])
                                    (let ([from (bytes->string/utf-8 (extract-field #"from" header))]
                                          [to (bytes->string/utf-8 (extract-field #"to" header))]
                                          [subject (bytes->string/utf-8 (extract-field #"subject" header))]
                                          [date (bytes->string/utf-8 (extract-field #"date" header))])
                                      (printf "message id: ~a~n" uid)
                                      (printf "  from: ~a~n" from)
                                      (printf "  to ~a~n" to)
                                      (printf "  subject ~a~n" subject)
                                      (printf "  date ~a~n" date))))
                                (imap-disconnect imap-conn))))))
                      )))))))))))
                      

