#lang racket

(require gregor)


(provide
 supported-mail-patterns
 parsable-as-datetime?
 supported-pattern-which-parses-date-time-string?
 possible-parse-date-time-string
 )

(define supported-mail-patterns
  (list
   "yyyy-MM-dd'T'HH:mm:ssxxx"
   "dd MMM yyyy HH:mm:ss"
   "dd MMM yyyy HH:mm:ss xxxx"
   "EEE, dd MMM yyyy HH:mm:ss xxxx"
   ;   "Sun, 21 Jun 2015 14:38:22 +0000"
   "EEE, dd MMM yyyy HH:mm:ss xxxx (z)"
   ;Sun, 21 Jun 2015 17:50:44 -0500 (CDT)
   ))

(define (parsable-as-datetime? candidate-date-string date-string-pattern)
  (printf "(parsable-as-datetime? ~a ~a)~n" candidate-date-string date-string-pattern)
  (and (string? candidate-date-string)
       (string? date-string-pattern)
       (with-handlers ((exn:gregor:parse? (lambda (e) #false)))
         (datetime? (parse-datetime candidate-date-string date-string-pattern)))))

  
(define (supported-pattern-which-parses-date-time-string? maybe-date-time-string)
  (for/first ([mail-pattern supported-mail-patterns]
              #:when (parsable-as-datetime? maybe-date-time-string mail-pattern))
    mail-pattern))
  
(define (possible-parse-date-time-string maybe-date-time-string)
  (for/first ([mail-pattern supported-mail-patterns]
              #:when (parsable-as-datetime? maybe-date-time-string mail-pattern))
    (parse-datetime maybe-date-time-string mail-pattern)))
 


;(parameterize ([current-locale "en"])
;    (list
;     (parse-time "January 24, 1977" "LLLL d, y")
;     (parse-time "2015-03-15T02:02:02-04:00" "yyyy-MM-dd'T'HH:mm:ssxxx")))
;
;
;(parameterize ([current-locale "en"])
;    (displayln (~t (date 1955 11 12) "E, MMMM d, y G"))
;    (displayln (~t (datetime 1955 11 12 2 42 30) "E h:mm a")))
;
;(append
; (list
;  (iso8601->date "1981-04-05")
;  (iso8601->time "13:47:30")
;  (iso8601->datetime "2014-03-20T19:20:09.3045")
;  )
; (parameterize ([current-locale "en"])
;    (list
;     (parse-date "January 24, 1977" "LLLL d, y")
;     (parse-date "2015-03-15T02:02:02-04:00" "yyyy-MM-dd'T'HH:mm:ssxxx")))
; (parameterize ([current-locale "en"])
;   (list
;    (parse-datetime "January 24, 1977" "LLLL d, y")
;    (parse-datetime "2015-03-15T02:02:02-04:00" "yyyy-MM-dd'T'HH:mm:ssxxx")))
; )
;
;(list
; (datetime? (parse-datetime "2015-03-15T02:02:02-04:00" "yyyy-MM-dd'T'HH:mm:ssxxx")))