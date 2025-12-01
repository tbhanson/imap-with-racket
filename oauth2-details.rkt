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
  [read-one-oauth2-details-from-file-named (-> (or/c string? path?) oauth2-details?)]


  ))

(define (read-oauth2-details a-port)
  (read a-port))
  
(define (read-one-oauth2-details-from-file-named filename)
  (read-oauth2-details
   (open-input-file filename)))
