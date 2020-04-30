#lang racket

(provide
 group-date-time-strings-by-parsing-pattern
 
; parse-date-time-string-statistics
 )

(require
  "parse-mail-dates.rkt")

; given an enumberable-of-date-time-strings, classify these by supported parsable date-time pattern (or "unsupported" if none works)
; return an object containing the hash we can query about stats
; 
(define (group-date-time-strings-by-parsing-pattern enumberable-of-date-time-strings)
  (for/fold ([addresses-by-patterns
              (hash)]
             #:result addresses-by-patterns)
            ([mail-address enumberable-of-date-time-strings])
    (let ([key (supported-pattern-which-parses-date-time-string? mail-address)])
      (values (hash-update addresses-by-patterns key (lambda (mail-addresses-at-key-so-far) (cons mail-address mail-addresses-at-key-so-far)) '())))))

           


; given an enumberable-of-date-time-strings, classify these by supported parsable date-time pattern (or "unsupported" if none works)
; return an object containing the hash we can query about stats
; 
;(define (parse-date-time-string-statistics enumberable-of-date-time-strings)
;  (let [(stats
;         (for/fold ([addresses-by-patterns
;                     (hash)])
;                   ([mail-address enumberable-of-date-time-strings])
;           
;    (define (dispatch msg)
;      (cond [(eq? msg 'add) (lambda (possible-mail-address) (hash-set stats possible-mail-address))]
;            [else (raise "error: i don't know how to ~a yet" msg)]))
;    dispatch))