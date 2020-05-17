#lang racket

(require rackunit
         rackunit/text-ui
         
         "main-mail-header-parts.rkt")

(run-tests
 (test-suite
  "all"

  
  (test-suite
   "main-mail-header-parts"

   (let ([id 123]
         [date-string "9 Oct 2014 18:23:20 -0000"]
         [from "do-not-reply@inbound.readersupportednews.org"]
         [to "tbhanson@gmx.de"])
     (let ([under-test
            (main-mail-header-parts
             id
             date-string
             from
             to
             ""
             ""
             "some subject")])
       (check-equal?
        (main-mail-header-parts? under-test)
        #t)
     
       (check-equal?
        (main-mail-header-parts-mail-id under-test)
        id)

       (check-equal?
        (main-mail-header-parts-date-string under-test)
        date-string)

       (check-equal?
        (main-mail-header-parts-from under-test)
        from)

       (check-equal?
        (main-mail-header-parts-to under-test)
        to)
       )
     )
   )
  )
 )

 