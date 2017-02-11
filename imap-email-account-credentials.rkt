#lang racket

(struct imap-email-account-credentials
  (accountname hostname mailaddress password)
  #:prefab
  )

(define (read-email-account-credentials port)
  (read port))

(define (read-email-account-credentials-from-file file)
  (read-email-account-credentials
   (open-input-file file)))

; make a container to hold multiple accounts with a way to get one imap-email-account-credentials by accountname for convenience
(define (read-email-account-credentials-hash file)
  (let ((account-list (read (open-input-file file))))
    (for/fold ([result (make-immutable-hash)])
              ([account account-list])
      (let ((key (imap-email-account-credentials-accountname account)))
        (values (hash-set result key account))))))
  
  
(provide
 imap-email-account-credentials
 imap-email-account-credentials?
 
 imap-email-account-credentials-accountname
 imap-email-account-credentials-hostname
 imap-email-account-credentials-mailaddress
 imap-email-account-credentials-password

 read-email-account-credentials
 read-email-account-credentials-from-file
 read-email-account-credentials-hash
 )
 