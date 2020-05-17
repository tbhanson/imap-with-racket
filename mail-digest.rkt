#lang racket

(require
  "main-mail-header-parts.rkt"
  "parse-mail-dates.rkt")

(provide
 (contract-out
  [mail-digest (-> integer? string? string? string? string? string? string? any/c)]
  ))

(define (mail-digest mail-id date-string from to cc bcc subj)
  (let ([parts (main-mail-header-parts mail-id date-string from to cc bcc subj)])
    (let ([date (possible-parse-date-time-string (main-mail-header-parts-date-string parts))])
      (define (dispatch msg)
        (cond
          [(eq? msg 'parts)
           parts]
          
          [(eq? msg 'date)
           date]
          
          [else (raise (format "error: i don't know how to ~a yet" msg))]))
      
      dispatch)
    )
  )
