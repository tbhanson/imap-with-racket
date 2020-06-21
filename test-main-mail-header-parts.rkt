#lang racket

(require rackunit
         rackunit/text-ui
         
         "main-mail-header-parts.rkt"
         racket/serialize)

(run-tests
 (test-suite
  "outer"
 
  (test-suite
   "main-mail-header-parts struct basics"

   (let ([id 123]
         [date-string "9 Oct 2014 18:23:20 -0000"]
         [from "do-not-reply@inbound.readersupportednews.org"]
         [to "uhclem@gmx.de"]
         [cc ""]
         [bcc ""]
         [subj "some subject"])
     (let ([under-test
            (main-mail-header-parts
             id
             date-string
             from
             to
             cc
             bcc
             subj)])
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
       
       (check-equal?
        (main-mail-header-parts-cc under-test)
        cc)

       (check-equal?
        (main-mail-header-parts-bcc under-test)
        bcc)

       (check-equal?
        (main-mail-header-parts-subj under-test)
        subj)

       )
     )
   )
  
  (test-suite
   "main-mail-header-parts constants"
   (check-equal?
    (null?
     (member #"bcc" main-mail-header-part-labels ))
    #f)

   (check-equal?
    main-mail-header-part-imap-symbols
    '(uid header)
    )
   )

  (test-suite
   "mail-header->main-mail-header-parts"
   (let ([name-of-file-containing-test-messages
          "test-data/one-test-msg-header-serialized.rkt"
          ])
     (let ([test-msg-serialized
            (read (open-input-string (file->string name-of-file-containing-test-messages)))])
       (let ([test-msg (deserialize test-msg-serialized)])
         (check-equal?
          (list? test-msg)
          #t)
         (check-equal?
          (length test-msg)
          2)
         (check-equal?
          (integer? (car test-msg))
          #t)
         (let ([main-mail-header-parts-maybe (mail-header->main-mail-header-parts test-msg)])
           ; redundant I guess because of contracts?
           (check-equal?
            (main-mail-header-parts? main-mail-header-parts-maybe)
            #t)
           ;(printf "main-mail-header-parts-maybe: ~a~n" main-mail-header-parts-maybe)
           )
         )
       )
     )
   )
  )
 )

