#lang racket

(require
  "main-mail-header-parts.rkt"
  "parse-mail-dates.rkt"
  net/head)

(provide
 (contract-out
  [mail-digest-from-fields (-> integer? string? string? string? string? string? string? list? any/c)]
  [mail-digest-from-header-parts (-> main-mail-header-parts? any/c)]
  ))


(define (mail-digest-from-fields mail-id date-string from to cc bcc subj flags)
  (let ([parts (main-mail-header-parts mail-id date-string from to cc bcc subj flags)])
    (mail-digest-from-header-parts parts)))


(define (mail-digest-from-header-parts parts)
  (let ([date (possible-parse-date-time-string (main-mail-header-parts-date-string parts))]
        [to-addrs (extract-addresses (main-mail-header-parts-to parts) 'address)]
        [cc-addrs (extract-addresses (main-mail-header-parts-cc parts) 'address)]
        [bcc-addrs (extract-addresses (main-mail-header-parts-bcc parts) 'address)]
        [flags (main-mail-header-parts-flags parts)])
    (let ([all-to-addrs
           (for/fold ([so-far (set)])
                     ([next-to-part (list to-addrs cc-addrs bcc-addrs)])
             (values (set-union so-far (list->set next-to-part))))])
      (define (dispatch msg)
        (cond
          [(eq? msg 'parts)
           parts]
          
          [(eq? msg 'date)
           date]
          
          [(eq? msg 'all-to)
           all-to-addrs]
          
          [else (raise (format "error: i don't know how to ~a yet" msg))]))
      
      dispatch)
    )
  )
