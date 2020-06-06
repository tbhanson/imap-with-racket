#lang racket

; work in progress

(require rackunit
         rackunit/text-ui
         racket/serialize

         "mailbox-digest.rkt"
         "imap-email-account-credentials.rkt"
         "range-of-messages.rkt"
         "main-mail-header-parts.rkt"
         )



(run-tests
 (test-suite
  "mailbox-digest"
  ))
  
