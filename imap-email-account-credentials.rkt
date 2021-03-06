#lang racket

; a structure to hold the basics we need
(struct imap-email-account-credentials
  (accountname hostname mailaddress password)
  #:prefab
  )

(provide
 ; automatic methods from struct
 (contract-out [imap-email-account-credentials (-> string? string? string? string? imap-email-account-credentials?)])
 imap-email-account-credentials?
 
 imap-email-account-credentials-accountname
 imap-email-account-credentials-hostname
 imap-email-account-credentials-mailaddress
 imap-email-account-credentials-password

 ; reading one or several
 (contract-out [read-one-email-account-credential (-> port? imap-email-account-credentials?)]
               [read-one-email-account-credentials-from-file-named (-> (or/c string? path?) imap-email-account-credentials?)]
               [read-email-account-credentials-hash-from-port (-> port? hash?)]
               [read-email-account-credentials-hash-from-file-named (-> (or/c string? path?) hash?)]
               ; convenience
               [default-ini-filepath (-> path?)]
               )
 )


; keep personal account set up and secrets in a standard place
(define (default-ini-filepath)
  (let ([iniFileName ".myImapCreds"])
    (let ([iniFilePath (build-path (find-system-path 'home-dir) iniFileName)])
      iniFilePath)))


; we chose a serialization of the above such that all we need is read :)
; cf. https://docs.racket-lang.org/guide/serialization.html#%28tech._serialization%29

(define (read-one-email-account-credential port)
  (read port))

; 
(define (read-one-email-account-credentials-from-file-named filename)
  (read-one-email-account-credential
   (open-input-file filename)))

; make a container to hold multiple accounts with a way to get one imap-email-account-credentials by accountname for convenience
(define (read-email-account-credentials-hash-from-port port)
  (let ((account-list (read port)))
    (for/fold ([result (make-immutable-hash)])
              ([account account-list])
      (let ([key (imap-email-account-credentials-accountname account)])
        (values (hash-set result key account))))))

(define (read-email-account-credentials-hash-from-file-named filename)
  (begin
    ;(assert (string? filename))
    ;(printf "(read-email-account-credentials-hash-from-file-named filename (~a)~n" filename)
    (read-email-account-credentials-hash-from-port
     (open-input-file filename))))
   
  

 