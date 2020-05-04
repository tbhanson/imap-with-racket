#lang racket

(provide
 parse-to-address-statistics
 )

(require
  net/head)

(define (parse-to-address-statistics enumerable-of-email-address-strings my-address)
  (define (address-matches addr1 addr2)
    (string-ci=? addr1 addr2))
  
  (define (includes-me? address-chain)
    (let ([moi (first (extract-addresses my-address 'address))])
      (for/first ([next-address (extract-addresses address-chain 'address)]
                  #:when (address-matches moi next-address))
        #t)))
  
  (let-values
      ([(including-me
         not-including-me)
               
        (for/fold ([to-chains-including-me '()]
                   [to-chains-not-including-me '()]
                   )
                  ;                 #:result (values to-chains-including-me to-chains-not-including-me)
                  ([next-item enumerable-of-email-address-strings])
          (if (includes-me? next-item)
              (values (cons next-item to-chains-including-me ) to-chains-not-including-me)
              (values to-chains-including-me (cons next-item to-chains-not-including-me ))))])

    (define (dispatch msg)
      (cond
        [(eq? msg 'including-me)
         including-me]
        
        [(eq? msg 'not-including-me)
         not-including-me]
        
        [else (raise (format "error: i don't know how to ~a yet" msg))]))
    
    dispatch))


