#lang racket

(require rackunit
         rackunit/text-ui
         "parse-mail-dates.rkt")


(require gregor)

(run-tests
  (test-suite
   "all"

   (test-suite
    "check we have known patterns"
    (check-equal?
     (empty? supported-mail-patterns)
     #f))

   (test-suite
    "test parsable-as-datetime?"
    (check-equal?
     (parsable-as-datetime? "2015-03-15T02:02:02-04:00" "yyyy-MM-dd'T'HH:mm:ssxxx")
     #t)
    (check-equal?
     (parsable-as-datetime?"21 Jun 2015 15:45:40 -0000" "yyyy-MM-dd'T'HH:mm:ssxxx")
     #f)
    )

   (test-suite
    "test supported-pattern-which-parses-date-time-string?"
    (check-equal?
     (supported-pattern-which-parses-date-time-string? "2015-03-15T02:02:02-04:00")
     "yyyy-MM-dd'T'HH:mm:ssxxx")
    (check-equal?
     (supported-pattern-which-parses-date-time-string? "21 Jun 2015 15:45:40 -0000")
     "dd MMM yyyy HH:mm:ss xxxx"
     )

    ; now supported with hack
    (check-equal?
     (supported-pattern-which-parses-date-time-string? "Sun, 21 Jun 2015 17:50:44 -0500 (CDT)")
     "EEE, dd MMM yyyy HH:mm:ss xxxx"
     )

    (check-equal?
     (supported-pattern-which-parses-date-time-string? "Thu, 9 Oct 2014 15:00:02 -0700 (PDT)")
     "EEE, d MMM yyyy HH:mm:ss xxxx"
     )

    

    )
   
   
   (test-suite
    "test possible-parse-date-time-string"
    (check-equal?
     (datetime? 
      (possible-parse-date-time-string "2015-03-15T02:02:02-04:00"))
     #t)

    (check-equal?
     (datetime? 
      (possible-parse-date-time-string "Sun, 21 Jun 2015 14:38:22 +0000"))
     #t)

    ; think about where the timezone goes
    (check-equal?
     (possible-parse-date-time-string "2015-03-15T02:02:02-04:00")
     (datetime
      2015 3 15 2 2 2))
    
    (check-equal?
     (possible-parse-date-time-string "21 Jun 2015 15:45:40")
     (datetime
      2015 6 21 15 45 40))

    (check-equal?
     (possible-parse-date-time-string "Sun, 21 Jun 2015 15:38:28 -0400 (EDT)")
     (datetime 2015 6 21 15 38 28) ; perhaps with added timezone info somewhere
     )
     
    (check-equal?
     (possible-parse-date-time-string "June 2, 1959; 12:34:56")
     #f)
    )
   )
 ) 
 