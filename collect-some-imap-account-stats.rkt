#lang racket

(require rackunit
         net/imap
         net/head
         "imap-email-account-credentials.rkt"
         "connect-to-imap-account.rkt"
         "range-of-messages.rkt"
         )


(provide
 (contract-out 
  [collect-some-imap-account-stats
   (-> imap-email-account-credentials?
       string?
       (lambda (item-index-range)
         (and (pair? item-index-range)
               (integer? (car item-index-range))
               (integer? (cdr item-index-range))
               (<= 1 (car item-index-range))
               (<= (car item-index-range)) (cdr item-index-range)))
       list?
       hash?)])
 )




; return hash of hashes:
; - outer key header-field 
; - inner hash is counts by value found in header-field
(define (collect-some-imap-account-stats email-account-credential mail-folder item-index-range header-fields)
  (let ([range-of-messages
         (get-range-of-messages email-account-credential mail-folder item-index-range)]
        [lo-index (car item-index-range)]
        [hi-index (cdr item-index-range)])      
    (for/fold ([result (make-immutable-hash)])
              ([field header-fields])
      (printf "field: ~a~n" field)
      (values (hash-set
               result
               field 
               (for/fold ([counts-by-field-value (make-immutable-hash)])
                         ([msg range-of-messages]
                          [idx (in-range lo-index (+ hi-index 1))])
                 (let ([uid (first msg)]
                       [header (second msg)])
                   ;(printf "header: ~a~n" header)
                   (let ([field-contents
                          (with-handlers
                              ([exn:fail?
                                (lambda (e)
                                  ;(format "??? (~a)" e)
                                  "" ; treat, e.g., a missing cc: field as empty
                                  )])
                            (bytes->string/utf-8 (extract-field field header)))])
                     (begin
                       (printf "idx: ~a~n" idx)
                       (printf "  uid: ~a~n" uid)
                       (printf "  counts-by-field-value: ~a~n" counts-by-field-value)
                       (printf "  field-contents: ~a~n" field-contents)
                       (printf "  (date? field-contents): ~a~n" (date? field-contents))
                       (printf "  (string? field-contents): ~a~n" (string? field-contents))
                       (values (hash-update counts-by-field-value field-contents (lambda (n) (+ n 1)) 0)))))
                 ))))))
