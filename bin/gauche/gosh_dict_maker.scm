#!/usr/bin/env gosh

(use gauche.interactive)

(define (main args)
  (let loop ((line (read-line)))
    (if (eof-object? line)
      (with-input-from-string
        (with-output-to-string
          (lambda ()
            (apropos '||)))
        (lambda ()
          (let loop ((line (read-line)))
            (unless (eof-object? line)
              (let1 symbol (read-from-string line)
                (when (global-variable-bound? (current-module) symbol)
                  (write symbol)
                  (newline))
                (loop (read-line)))))))
      (begin
        (with-error-handler
          (lambda (e)
            (warn (ref e 'message)))
          (lambda ()
            (eval `(use ,(string->symbol line)) (interaction-environment))
            (print line)))
        (loop (read-line))))))
