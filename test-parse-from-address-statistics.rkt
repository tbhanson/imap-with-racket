#lang racket

(require rackunit
         rackunit/text-ui
         net/head
         "parse-from-address-statistics.rkt")


(run-tests
 (test-suite
  "all"

  
  (test-suite
   "parse-from-address-statistics"
  
   "empty list"
   (check-equal?
    (parse-from-address-statistics '())
    (hash))
   
   "one non-parsable item"
   (let ([non-parsable-email-address "4th of Julie<>"])
     (test-suite
      "test assumptions and tools"
      
      (check-equal?
       (extract-addresses non-parsable-email-address 'address)
       '("")
       )
      
      (check-equal?
       (extract-addresses "John Doe <doe@localhost>" 'address)
       (list "doe@localhost")
       )
      
      (check-equal?
       (extract-addresses "John Doe <doe@localhost>, Also John Doe <doe@localhost>" 'address)
       (list "doe@localhost" "doe@localhost")
       )
      
      )
     )
   
   )
  )
 )