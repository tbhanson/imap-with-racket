#lang racket

(require rackunit
         rackunit/text-ui

         gregor
         net/head
         "mail-digest.rkt"
         "main-mail-header-parts.rkt"

         racket/serialize
         net/imap
         )

(run-tests
 (test-suite
  "all"
   
  (test-suite
   "mail-digest-from-fields"

   (let ([id 123]
         [date-string "9 Oct 2014 18:23:20 -0000"]
         [from "do-not-reply@inbound.readersupportednews.org"]
         [to "uhClem@gmx.de,clem@kadiddlehopper.org"]
         [cc "bogsat3@googlegroups.com"]
         [bcc ""]
         [subj "some subject"]
         [flags (map symbol->imap-flag (list 'seen 'answered))])
     (let ([under-test
            (mail-digest-from-fields
             id
             date-string
             from
             to
             cc
             bcc
             subj
             flags)])
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

  (test-suite
   "mail-digest-from-header-parts"

   (let ([name-of-file-containing-test-messages
          "test-data/another-test-msg-header-serialized.rkt"
          ])
     (let ([test-msg
            (deserialize 
             (read (open-input-string (file->string name-of-file-containing-test-messages))))])
       (let ([main-mail-header-parts-maybe (mail-header->main-mail-header-parts test-msg)])
         (let ([under-test (mail-digest-from-header-parts main-mail-header-parts-maybe)])
           (check-equal?
            (under-test 'date)
            (datetime
             2014 10 9 18 23 20)
            )

           (check-equal?
            (under-test 'year)
            2014)

           (check-equal?
            (under-test 'from-addr)
            "do-not-reply@inbound.readersupportednews.org")

           (check-equal?
            (under-test 'to-addrs)
            (list "uhClem@gmx.de"))

           (check-equal?
            (under-test 'parts)
            (main-mail-header-parts
             50817
             "9 Oct 2014 18:23:20 -0000"
             "\"Reader Supported News\" <do-not-reply@inbound.readersupportednews.org>"
             "uhClem@gmx.de"
             ""
             ""
             ""
             (map symbol->imap-flag (list 'seen))
             )  
            )
           
           )
         )
       )
     
     
     )
   
   )
  )
 )