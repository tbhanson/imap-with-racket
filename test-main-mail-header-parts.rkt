#lang racket

(require rackunit
         rackunit/text-ui
         
         "main-mail-header-parts.rkt")

(run-tests
 (test-suite
  "outer"
 
  (test-suite
   "main-mail-header-parts struct basics"

   (let ([id 123]
         [date-string "9 Oct 2014 18:23:20 -0000"]
         [from "do-not-reply@inbound.readersupportednews.org"]
         [to "tbhanson@gmx.de"]
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
   "main-mail-header-parts constants"
   (check-equal?
    (null?
     (member #"bcc" main-mail-header-part-labels ))
    #f)
   )

  (test-suite
   "mail-header->main-mail-header-parts"
   (let ([name-of-file-containing-test-messages "test-data/data-raw-mail-bits.rkt"])
     (let ([test-msg-list
            (read (open-input-string (file->string name-of-file-containing-test-messages)))])
       (check-equal?
        (list? test-msg-list)
        #t)
       (check-equal?
        (length test-msg-list)
        2)
       (let ([test-msg-maybe (cadr test-msg-list)])
         (let ([main-mail-header-parts-maybe (mail-header->main-mail-header-parts test-msg-maybe)])
           ; redundant I guess because of contracts?
           (check-equal?
            (main-mail-header-parts? main-mail-header-parts-maybe)
            #t)
           ))
       ))
   )
  )
 )

 