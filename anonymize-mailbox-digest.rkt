#lang racket

(require
  net/head)

(define (default-anonymizer-rules-filepath)
  (let ([anonymizerRulesFileName ".myAnonymizerRules"])
    (let ([anonymizerRulesFilePath (build-path (find-system-path 'home-dir) anonymizerRulesFileName)])
      anonymizerRulesFilePath)))


(define (read-anoymizer-hash-from-port port)
  (let ((before-after-pairs-list (read port)))
    (for/fold ([result (make-immutable-hash)])
              ([before-after-pair before-after-pairs-list])
      (let ([before (first before-after-pair)]
            [after (second before-after-pair)])
        ;(printf "before: ~a, after: ~a~n" before after)
        (values (hash-set result before after))))))

(define (read-anoymizer-hash-from-file-named filename)
  (begin
    (read-anoymizer-hash-from-port
     (open-input-file filename))))

(define (load-default-anonymizer-rules)
  (read-anoymizer-hash-from-file-named (default-anonymizer-rules-filepath)))

(define default-rules
  (load-default-anonymizer-rules))

(define (anonymize-one-string in)
  (hash-ref default-rules in))



(provide
 ; reading one or several
 (contract-out [anonymize-one-string (-> string? string?)]
               ; convenience
               [default-anonymizer-rules-filepath (-> path?)]
               [load-default-anonymizer-rules (-> list?)]
               )
 )