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
   
   (let ([not-really-an-address-at-all "no at sign"])
     (check-equal?
      (parse-from-address-statistics (list not-really-an-address-at-all))
      (hash-set
       (hash)
       not-really-an-address-at-all
       1
       )))

   
   )


  (test-suite
   "test assumptions and tools"

   ; how does extract-addresses work? a bit strangely
   (let ([not-really-an-address-at-all "nobody at home"]
         [pretends-to-contain-an-address "outer<inner>"])
     ; not quite the solution I expected
     (check-equal?
      (extract-addresses not-really-an-address-at-all 'address)
      (list not-really-an-address-at-all)
      )

     ; well, at least consistent
     (check-equal?
      (extract-addresses pretends-to-contain-an-address 'address)
      (list "inner")
      )
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