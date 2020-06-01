#lang racket

(require rackunit
         rackunit/text-ui
         net/head
         "parse-to-address-statistics.rkt")

(run-tests
 (test-suite
  "all"

  
  (test-suite
   "parse-to-address-statistics"
  
   "empty list"
   (let ([under-test (parse-to-address-statistics '() "moi")])
     (check-equal?
      (under-test 'including-me)
      '())

     (check-equal?
      (under-test 'not-including-me)
      '()))

   "list including me"
   (let ([under-test (parse-to-address-statistics (list "fred,moi,ginger") "moi")])
     (check-equal?
      (under-test 'including-me)
      (list "fred,moi,ginger"))

     (check-equal?
      (under-test 'not-including-me)
      '()))

   "list not including me"
   (let ([under-test (parse-to-address-statistics (list "fred,ginger") "moi")])
     (check-equal?
      (under-test 'including-me)
      '())
     
     (check-equal?
      (under-test 'not-including-me)
      (list "fred,ginger")))
   )
  )
 )


  