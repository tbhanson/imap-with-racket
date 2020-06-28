#lang racket

(require
  net/head)

(define (default-anonymizer-rules-filepath)
  (let ([anonymizerRulesFileName ".myAnonymizerRules"])
    (let ([anonymizerRulesFilePath (build-path (find-system-path 'home-dir) anonymizerRulesFileName)])
      anonymizerRulesFilePath)))


(define (read-anonymizer-hash-from-port port)
  (let ((before-after-pairs-list (read port)))
    (for/fold ([result (make-immutable-hash)])
              ([before-after-pair before-after-pairs-list])
      (let ([before (first before-after-pair)]
            [after (second before-after-pair)])
        ;(printf "before: ~a, after: ~a~n" before after)
        (values (hash-set result before after))))))

(define (read-anonymizer-hash-from-file-named filename)
  (begin
    (read-anonymizer-hash-from-port
     (open-input-file filename))))

(define (load-default-anonymizer-rules)
  (read-anonymizer-hash-from-file-named (default-anonymizer-rules-filepath)))

(define default-rules
  (load-default-anonymizer-rules))

(define (anonymize-one-string in)
  (for/fold ([result in])
            ([before-value (hash-keys default-rules)])
    (values (string-replace result before-value
                            (hash-ref default-rules before-value)))))



(provide
 ; reading one or several
 (contract-out [anonymize-one-string (-> string? string?)]
               ; convenience
               [default-anonymizer-rules-filepath (-> path?)]
               [load-default-anonymizer-rules (-> hash?)]
               ;[anonymize-mailbox-digest (-> mailbox-digest? mailbox-digest?)]
               
               )
 )
