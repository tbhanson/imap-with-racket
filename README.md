# imap-with-racket

(still very chaotic)

eventual goals:

- support scripting connections to imap servers to allow purging old, expendable mail

For now credentials are kept in ~/.myImapCreds in a format such as found in

  test-data/list-of-test-imap-email-account-credentials.rkt

- - - -

2020-05-13

some immediate next goals

- in a run of 10^n, identify mail whose to fields (to, cc, bcc) do not include me
- in a run of 10^n mails, select the parts I’ll need to make purge-or-keep decisions:
    - mail ID
    - combined to fields
    - from
    - parsed date (so we can ask how old)
- think about rules we can support, e.g.
    - mails from these senders older than … we would purge
    - mails from 
- check out essentials of mails our rule identifies to purge and make sure I approve
- think about
    - whether it makes sense to store essentials locally for a while (both for developing unit tests and to save time)
    - do mail IDs remain constant even as mail indices (presumably) change ?
    - can we tell whether we have read a mail (or is that kept in the mail client?)
    - how we actually delete a mail
    - how we check progress (e.g. the overall number of mails remaining in the box)
