#lang racket

(require gregor)


(provide
 possible-parse-date-time-string
 )

(define (possible-parse-date-time-string maybe-date-time-string)
  (parse-datetime maybe-date-time-string "yyyy-MM-dd'T'HH:mm:ssxxx"))


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