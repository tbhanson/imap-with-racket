#lang racket

(require rackunit
         rackunit/text-ui

         gregor
         net/head
         "mail-digest.rkt"
         )

(run-tests
  (test-suite
   "mail-digest"

   (let ([id 123]
         [date-string "9 Oct 2014 18:23:20 -0000"]
         [from "do-not-reply@inbound.readersupportednews.org"]
         [to "tbhanson@gmx.de"]
         [cc "bogsat3@googlegroups.com"]
         [bcc ""]
         [subj "some subject"])
     (let ([under-test
            (mail-digest
             id
             date-string
             from
             to
             cc
             bcc
             subj)])
       (check-equal?
        (under-test 'date)
        (datetime
         2014 10 9 18 23 20)
        )

       (check-equal?
        (under-test 'all-to)
        (for/fold ([so-far (set)])
                  ([next-to-part (list to cc bcc)])
          (values (set-union so-far (list->set  (extract-addresses next-to-part 'address)))))
        )
       )
     )
   )
  )

