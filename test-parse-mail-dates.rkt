#lang racket

(require rackunit
         "parse-mail-dates.rkt")

(require gregor)


(check-equal?
 (datetime? 
  (possible-parse-date-time-string "2015-03-15T02:02:02-04:00"))
 #t)

(check-equal?
 (possible-parse-date-time-string "2015-03-15T02:02:02-04:00")
 (datetime
  2015 3 15 2 2 2))

(check-exn
   exn:fail?
   (lambda ()
     (raise (make-exn:fail "Hi there"
                           (current-continuation-marks)))))


(check-exn
   exn:gregor:parse?
   (lambda ()
     (possible-parse-date-time-string "21 Jun 2015 15:45:40 -0000")))
