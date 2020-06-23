#lang racket

(require
  net/head)

; a structure to hold the basics we need
(struct main-mail-header-parts
  (mail-id date-string from to cc bcc subj flags)
  #:prefab
  )

(provide
 (contract-out
  ; struct automatics
  [main-mail-header-parts (-> integer? string? string? string? string? string? string? list? main-mail-header-parts?)]
  [main-mail-header-parts? (-> any/c boolean?)]
  [main-mail-header-parts-mail-id (-> main-mail-header-parts? integer?)]
  [main-mail-header-parts-date-string (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-from (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-to (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-cc (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-bcc (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-subj (-> main-mail-header-parts? string?)]
  [main-mail-header-parts-flags (-> main-mail-header-parts? list?)]

  ; convenience converter
  [mail-header->main-mail-header-parts (-> (and/c pair? list?) main-mail-header-parts?)]
  )
 
 ; constants we might need
 main-mail-header-part-labels
 main-mail-header-part-imap-symbols
 )

(define main-mail-header-part-labels
  (list #"date" #"from" #"to" #"cc" #"bcc" #"subj"))

(define main-mail-header-part-imap-symbols
  '(uid header flags))

(define (mail-header->main-mail-header-parts msg)
  (define (field-contents field header)
    (with-handlers
        ([exn:fail?
          (lambda (e)
            ;(format "??? (~a)" e)
            "" ; treat, e.g., a missing cc: field as empty
            )])
      (bytes->string/utf-8 (extract-field field header))))
  
  (let ([uid (first msg)]
        [header (second msg)]
        [flags (third msg)]
        )
    ;(printf "header: ~a~n" header)
    (let ([mail-id uid]
          [date-string (field-contents #"date" header)]
          [from (field-contents #"from" header)]
          [to (field-contents #"to" header)]
          [cc (field-contents #"cc" header)]
          [bcc (field-contents #"bcc" header)]
          [subj (field-contents #"subj" header)]
          )
      (main-mail-header-parts
       mail-id date-string from to cc bcc subj flags))))


   

