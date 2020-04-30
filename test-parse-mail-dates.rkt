#lang racket

(require rackunit
         rackunit/text-ui
         "parse-mail-dates.rkt")


(require gregor)

(run-tests
  (test-suite
   "all"
   
   (test-suite
    "test parsable-as-datetime?"
    (check-equal?
     (parsable-as-datetime? "2015-03-15T02:02:02-04:00" "yyyy-MM-dd'T'HH:mm:ssxxx")
     #t)
    (check-equal?
     (parsable-as-datetime?"21 Jun 2015 15:45:40 -0000" "yyyy-MM-dd'T'HH:mm:ssxxx")
     #f))
   
   (test-suite
    "test possible-parse-date-time-string"
    (check-equal?
     (datetime? 
      (possible-parse-date-time-string "2015-03-15T02:02:02-04:00"))
     #t)
    
    (check-equal?
     (possible-parse-date-time-string "2015-03-15T02:02:02-04:00")
     (datetime
      2015 3 15 2 2 2))
    
    (check-equal?
     (possible-parse-date-time-string "21 Jun 2015 15:45:40")
     (datetime
      2015 6 21 15 45 40))
    
    (check-equal?
     (possible-parse-date-time-string "June 2, 1959; 12:34:56")
     #f)
    )
   )
 ) 
 