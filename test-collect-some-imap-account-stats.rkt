#lang racket

(require rackunit
         net/imap
         net/head

         "imap-email-account-credentials.rkt"
         "collect-some-imap-account-stats.rkt"
         "parse-date-time-string-statistics.rkt"
         "parse-to-address-statistics.rkt"
         )



; compute some statistics for "INBOX" of a real account
; NB: when I upped the count examined from 10 to 100 the real time spent was 3+ seconds, up from 3- seconds
; when I upped it from 100 to 1000, time elapsed was about 4.4s
; however, at 1000 I noticed that stats on "to" are not very interesting: I get all the different combinations incuding various spellings of myself
; from is still interesting and I think the next project will be looking at date sent collapsed into year or year-month, I suspect
(let ([iniFilePath (default-ini-filepath)])
  (let ([creds_hash (read-email-account-credentials-hash-from-file-named iniFilePath)])
    (for ([test-acct-name (list "tbhanson gmx" ;"tim at w-h"
                                )])
      (let* ([test-acct (hash-ref creds_hash test-acct-name)]
             [my-address (imap-email-account-credentials-mailaddress test-acct)])
        (printf "my-address: ~a~n" my-address)
        (let ([fields (list #"from"
                            #"date"
                            #"to"
                            #"cc"
                            )]
              [msg-count-to-examine 1])
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
                (begin
                  (printf "-------~n")
                  (cond [(eq? key #"date")
                         (let ([date-strings-by-parsing-pattern-stats
                                (parse-date-time-string-statistics (hash-keys (hash-ref under-test #"date")))])
                           (begin
                             (printf "(date-strings-by-parsing-pattern-stats 'show-counts-by-date-string-pattern) ~a~n"
                                     (date-strings-by-parsing-pattern-stats 'show-counts-by-date-string-pattern))
                             (printf "(date-strings-by-parsing-pattern-stats 'show-counts-by-year):~n ~a~n"
                                     (date-strings-by-parsing-pattern-stats 'show-counts-by-year))
                             (printf "(date-strings-by-parsing-pattern-stats 'date-strings-not-parsed):~n ~a~n"
                                     (date-strings-by-parsing-pattern-stats 'date-strings-not-parsed))
                             ))]
                        
                        [(or
                          (eq? key #"to")
                          (eq? key #"cc"))
                         (let ([to-strings-with-and-without-me
                                (parse-to-address-statistics (hash-keys (hash-ref under-test key)) my-address)])
                           (begin
                             (printf "((~a) to-strings-with-and-without-me 'including-me): ~a~n"
                                     key
                                     (pretty-format (to-strings-with-and-without-me 'including-me)))
                             (printf "((~a) to-strings-with-and-without-me 'not-including-me): ~a~n"
                                     key
                                     (pretty-format (to-strings-with-and-without-me 'not-including-me)))))]
                             
                        
                        [(eq? key #"from")
                         (printf "under-test at ~a: ~a~n" key
                                 (pretty-print (hash-ref under-test key)))]
                        [else
                         (printf "oops! no path for key: ~a~n" key)]
                        
                        )))

              )))))))

