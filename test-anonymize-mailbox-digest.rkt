#lang racket

(require rackunit
         rackunit/text-ui
         
         "anonymize-mailbox-digest.rkt"
         ;racket/serialize
         )

(run-tests
 (test-suite
  "outer"
 
  (test-suite
   "anonymize-one-string"
   (check-equal?
    (anonymize-one-string "tbhanson")
    "uhclem")

   (check-equal?
    (anonymize-one-string "tbhanson@weber-hanson.com")
    "uhclem@some-domain.com")
   )

  
  (test-suite
   "default-anonymizer-rules-filepath"
   (check-equal?
    (file-exists?
     (default-anonymizer-rules-filepath))
    #t
    )
   )
  
  ))
