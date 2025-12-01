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
  [oauth2-details-filename (-> string? path?)]
  [oauth2-details-filepath-from-dir (-> path? string? path?)]
  [default-oauth2-details-filepath (-> string? path?)]
  [write-oauth2-details-to-file (-> oauth2-details? path? void?)]
  ))

(define (read-oauth2-details a-port)
  (read a-port))
  
(define (read-one-oauth2-details-from-file-named filename)
  (read-oauth2-details
   (open-input-file filename)))

; filename to save these to or read from
(define (oauth2-details-filename email-address)
  (let ([iniFileNameBase ".myImapOauth2Details"])
    (build-path
     (format "~a_~a" iniFileNameBase email-address))))

; filepath relative to a given directory to save these to or read from
(define (oauth2-details-filepath-from-dir dir email-address)
  (build-path dir (oauth2-details-filename email-address)))

; standard  to save these to or read from
(define (default-oauth2-details-filepath email-address)
  (oauth2-details-filepath-from-dir (find-system-path 'home-dir) email-address))

; write to file
(define (write-oauth2-details-to-file one-oauth2-details output-file-path)
  (let ([output-port
         (open-output-file output-file-path #:exists 'replace #:permissions #o600)])
    (write one-oauth2-details output-port)
    (close-output-port output-port)))
