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
   "d MMM yyyy HH:mm:ss xxxx"

   "EEE, dd MMM yyyy HH:mm:ss xxxx"
   ; "Sun, 21 Jun 2015 14:38:22 +0000"

   "EEE, dd MM yyyy HH:mm:ss"
   ; "Mon, 20 10 2014 04:00:10"

   ; this one won't work and will require another work-around: 4-character day-of-week abbreviations are not specified at the standard
   ; cf. https://www.unicode.org/reports/tr35/tr35-59/tr35-dates.html#Week_Data
   ;
   ;"EEEE, dd MMM yyyy HH:mm:ss xxxx"
   ; "Tues, 28 Oct 2014 03:42:57 -0800"
   

   "EEE, d MMM yyyy HH:mm:ss xxxx"
   ; "Thu, 9 Oct 2014 15:00:02 -0700 (PDT)"   

   ; the parenthetical at the end of the next is redundant and ambiguous (the latter part being not really supportable)
   ; the most pragmatic approach for me at the moment would seem to be to strip it off (at which point the previous rule should work)
   ;"EEE, dd MMM yyyy HH:mm:ss xxxx (z)"
   ;Sun, 21 Jun 2015 17:50:44 -0500 (CDT)
   ))

(define (remove-redundant-ambiguous-suffix date-time-string)
  (let ([possible-match (regexp-match-positions #px"[-+][0-9]{4}( [(][A-Z]+[)])$" date-time-string)])
    (if possible-match
        (substring date-time-string 0 (car (second possible-match)))
        date-time-string)))

(define (remove-non-compliant-day-of-week-prefix date-time-string)
  (let ([possible-match (regexp-match-positions #px"^[A-Z][a-z]{3}, " date-time-string)])
    (if possible-match
        (substring date-time-string (cdr (first possible-match)))
        date-time-string)))

; clean up some prefixes and suffixes we can't handle
; incidentally, since we need both of these anyway and since both the prefixex (some forms of day of week) and
; suffixes (ambiguous, but human-friendly timezone name) are redundant, we could perhaps always strip both
; using somewhat more all-encompassing patterns and save ourselves a few patterns
(define (sanitize-input-date-time-string date-time-string)
  (remove-non-compliant-day-of-week-prefix
   (remove-redundant-ambiguous-suffix date-time-string)))


(define (parsable-as-datetime? candidate-date-string date-string-pattern)
  ;(printf "(parsable-as-datetime? ~a ~a)~n" candidate-date-string date-string-pattern)
  (and (string? candidate-date-string)
       (string? date-string-pattern)
       (let ([possibly-tweaked-input
              (sanitize-input-date-time-string candidate-date-string)])
              
         (with-handlers ([exn:gregor:parse? (lambda (e) #f)]
                         ;[exn:fail? (lambda (e) #f)]  ; not needed with built-in (remove-redundant-ambiguous-suffix x) work-around
                         )
           (datetime? (parse-datetime possibly-tweaked-input date-string-pattern))))))

  
(define (supported-pattern-which-parses-date-time-string? maybe-date-time-string)
  (let ([possibly-tweaked-input
         (sanitize-input-date-time-string maybe-date-time-string)])

    (for/first ([mail-pattern supported-mail-patterns]
                #:when (parsable-as-datetime? possibly-tweaked-input mail-pattern))
      mail-pattern)))
  
(define (possible-parse-date-time-string maybe-date-time-string)
  (let ([possibly-tweaked-input
         (sanitize-input-date-time-string maybe-date-time-string)])

    (for/first ([mail-pattern supported-mail-patterns]
                #:when (parsable-as-datetime? possibly-tweaked-input mail-pattern))
      (parse-datetime possibly-tweaked-input mail-pattern))))
 


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