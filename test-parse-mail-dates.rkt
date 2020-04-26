#lang racket

(require rackunit
         "parse-mail-dates.rkt")


(check-equal?
 (possible-parse-date-time-string "21 Jun 2015 15:45:40 -0000")
 #t)