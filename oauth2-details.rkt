#lang racket

; a structure to hold the basics we need
(struct oauth2-details
  (client-id client-secret redirect-uri)
  #:prefab
  )

(provide
 (contract-out
  ; automatic methods from struct
  [oauth2-details? (-> any/c boolean?)]
  [oauth2-details (-> string? string? string? oauth2-details?)]
  [oauth2-details-client-id (-> oauth2-details? string?)]
  [oauth2-details-client-secret (-> oauth2-details? string?)]
  [oauth2-details-redirect-uri (-> oauth2-details? string?)]
  ; reading or writing
  [read-oauth2-details (-> port? oauth2-details?)]
  ;  [read-one-email-account-credentials-from-file-named (-> (or/c string? path?) imap-email-account-credentials?)]


  ))

(define (read-oauth2-details a-port)
  (read a-port))
  
