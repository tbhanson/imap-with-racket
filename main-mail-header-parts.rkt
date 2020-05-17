#lang racket

; a structure to hold the basics we need
(struct main-mail-header-parts
  (mail-id date-string from to Cc Bcc subj)
  #:prefab
  )

(provide
 (contract-out
  [main-mail-header-parts (-> integer? string? string? string? string? string? string? main-mail-header-parts?)]
  [main-mail-header-parts? (-> any/c boolean?)]
  [main-mail-header-parts-mail-id (-> main-mail-header-parts? integer?)]
  [main-mail-header-parts-date-string (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-from (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-to (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-Cc (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-Bcc (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-subj (-> main-mail-header-parts? string?)]
  )
 )
