#lang racket

(provide
 parse-from-address-statistics
 )

(require
  net/head)

(define (parse-from-address-statistics enumerable-of-email-address-strings)
  (let ([just-addresses
         (for/fold ([addresses-so-far '()])
                   ([next-item enumerable-of-email-address-strings])
           (values (append addresses-so-far (extract-addresses next-item))))])
    (for/fold ([result (hash)])
              ([next-address just-addresses])
      (values
       (hash-update result next-address (lambda (count-of-address) (+ count-of-address 1)) 0)))))