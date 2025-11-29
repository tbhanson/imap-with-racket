#lang racket

; a structure to hold the basics we need
(struct oauth2-details
  (client-id client-secret redirect-uri)
  #:prefab
  )

(provide
 ; automatic methods from struct
 (contract-out
  [oauth2-details (-> string? string? string? oauth2-details?)]))
