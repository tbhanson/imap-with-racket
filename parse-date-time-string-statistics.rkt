#lang racket

(provide
 group-date-time-strings-by-parsing-pattern
 parse-date-time-string-statistics
 )

(require
  gregor
  "parse-mail-dates.rkt")

; given an enumberable-of-date-time-strings, classify these by supported parsable date-time pattern (or "unsupported" if none works)
; return a hash of lists of date-time strings by pattern that successfully parses them 
(define (group-date-time-strings-by-parsing-pattern enumberable-of-date-time-strings)
  (for/fold ([addresses-by-patterns
              (hash)]
             #:result addresses-by-patterns)
            ([date-time-string enumberable-of-date-time-strings])
    (let ([key (supported-pattern-which-parses-date-time-string? date-time-string)])
      (values (hash-update addresses-by-patterns key (lambda (date-time-strings-at-key-so-far) (cons date-time-string date-time-strings-at-key-so-far)) '())))))

           


; given an enumberable-of-date-time-strings, classify these by supported parsable date-time pattern (or "unsupported" if none works)
; return an object that lets us query the stats
(define (parse-date-time-string-statistics enumberable-of-date-time-strings)
  (define (get-counts-by-key a-hash)
    (for/fold ([counts-by-key
                (hash)])
              ([key (hash-keys a-hash)])
      (values (hash-set counts-by-key key (length (hash-ref a-hash key))))))
  
  (let ([counts-by-date-string-pattern
         (group-date-time-strings-by-parsing-pattern enumberable-of-date-time-strings)]
        [counts-by-year
         (for/fold ([count-by-year (hash)])
                   ([date-time-string enumberable-of-date-time-strings])
           (let ([hopefully-date-time (possible-parse-date-time-string date-time-string)])
             (if hopefully-date-time
                 (let ([year (->year hopefully-date-time)])
                   (values (hash-update count-by-year year (lambda (year-count) (+ year-count 1)) 0)))
                 (values count-by-year))
             ))])
    
    (define (dispatch msg)
      (cond
        
        [(eq? msg 'counts-by-date-string-pattern)
         (get-counts-by-key counts-by-date-string-pattern)
         ]
        
        [(eq? msg 'show-counts-by-date-string-pattern)
         (pretty-format
          (get-counts-by-key counts-by-date-string-pattern))
         ]

        [(eq? msg 'counts-by-year)
         counts-by-year
         ]
        
        [(eq? msg 'show-counts-by-year)
         (pretty-format
          counts-by-year)
         ]

        [(eq? msg 'date-strings-not-parsed)
         (hash-ref counts-by-date-string-pattern #f '())
         ]
        
        [else (raise (format "error: i don't know how to ~a yet" msg))]))
    dispatch))
