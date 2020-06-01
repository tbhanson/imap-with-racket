#lang racket

(require rackunit
         net/imap
         net/head
         "imap-email-account-credentials.rkt"
         "connect-to-imap-account.rkt"
         )


(provide
 (contract-out 
  [get-range-of-messages
   (-> imap-email-account-credentials?
       string?
       (lambda (item-index-range)
         (and (pair? item-index-range)
               (integer? (car item-index-range))
               (integer? (cdr item-index-range))
               (<= 1 (car item-index-range))
               (<= (car item-index-range)) (cdr item-index-range)))
       list?)])
 )




; return list of messages indexed low to high (from the item-index-range pair)
(define (get-range-of-messages email-account-credential mail-folder item-index-range)               
  (let ([imap-conn
         (securely-connect-to-imap-account email-account-credential mail-folder)])
    (let ([msg-count (imap-messages imap-conn)]
          [lo-index (car item-index-range)])
      (let ([hi-index (min msg-count (cdr item-index-range))])
        (begin
          (printf "there are ~a messages in folder ~a of account ~a~n" msg-count mail-folder (imap-email-account-credentials-accountname email-account-credential))
          ;(assert (<= lo-index msg-count) (format "autschn! lo-index ~a is larger than msg-count ~a~n" lo-index msg-count))
          (printf "we will look at those indexed ~a to ~a~n" lo-index hi-index)
          (let ([range-of-messages (imap-get-messages imap-conn (stream->list (in-range lo-index (+ hi-index 1))) '(uid header))])
            range-of-messages))))))