#lang racket

(require rackunit
         rackunit/text-ui
         "parse-date-time-string-statistics.rkt")

(run-tests
 (test-suite
  "all"
  
  (test-suite
   "group-date-time-strings-by-parsing-pattern"
  
   "empty list"
   (check-equal?
    (group-date-time-strings-by-parsing-pattern '())
    (hash))
  
   "one non-parsable item"
   (let ([non-parsable-datetime "4th of Julie"])
     (check-equal?
      (group-date-time-strings-by-parsing-pattern (list non-parsable-datetime))
      (hash-set
       (hash)
       #f
       (list non-parsable-datetime))))
  
   "one parsable item"
   (let ([parsable-datetime "2015-03-15T02:02:02-04:00"])
     (check-equal?
      (group-date-time-strings-by-parsing-pattern (list parsable-datetime))
      (hash-set
       (hash)
       "yyyy-MM-dd'T'HH:mm:ssxxx"
       (list parsable-datetime))))
   )
 
  (test-suite
   "parse-date-time-string-statistics"
  
   "empty list"
  
   (let ([under-test (parse-date-time-string-statistics '())])
     (check-equal?
      (under-test 'keys)
      '())

     (check-equal?
      (under-test 'counts-by-key)
      (hash))
     )

   "one non-parsable item"
   (let ([non-parsable-datetime "4th of Julie"])
     (let ([under-test (parse-date-time-string-statistics (list non-parsable-datetime))])
       (check-equal?
        (under-test 'keys)
        (list #f))

       (check-equal?
        (under-test 'counts-by-key)
        (hash-set (hash) #f 1)
        )
       )
     )
   )
  )
 )


 