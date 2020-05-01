#lang racket

(provide
 group-date-time-strings-by-parsing-pattern
 parse-date-time-string-statistics
 )

(require
  "parse-mail-dates.rkt")

; given an enumberable-of-date-time-strings, classify these by supported parsable date-time pattern (or "unsupported" if none works)
; return a hash of lists of date-time strings by pattern that successfully parses them 
(define (group-date-time-strings-by-parsing-pattern enumberable-of-date-time-strings)
  (for/fold ([addresses-by-patterns
              (hash)]
             #:result addresses-by-patterns)
            ([mail-address enumberable-of-date-time-strings])
    (let ([key (supported-pattern-which-parses-date-time-string? mail-address)])
      (values (hash-update addresses-by-patterns key (lambda (mail-addresses-at-key-so-far) (cons mail-address mail-addresses-at-key-so-far)) '())))))

           


; given an enumberable-of-date-time-strings, classify these by supported parsable date-time pattern (or "unsupported" if none works)
; return an object containing the hash we can query about stats
(define (parse-date-time-string-statistics enumberable-of-date-time-strings)
  (define (get-counts-by-key a-hash)
    (for/fold ([counts-by-key
                (hash)])
              ([key (hash-keys a-hash)])
      (values (hash-set counts-by-key key (length (hash-ref a-hash key))))))
  
  (let ([stats
         (group-date-time-strings-by-parsing-pattern enumberable-of-date-time-strings)])
    
    (define (dispatch msg)
      (cond [(eq? msg 'keys)
             (hash-keys stats)
             ]
            
            [(eq? msg 'show-keys)
             (pretty-print (hash-keys stats))
             ]
            
            [(eq? msg 'counts-by-key)
             (get-counts-by-key stats)
             ]
            
            [(eq? msg 'show-counts-by-key)
             (pretty-print
              (get-counts-by-key stats))
             ]
            
            [else (raise (format "error: i don't know how to ~a yet" msg))]))
    dispatch))