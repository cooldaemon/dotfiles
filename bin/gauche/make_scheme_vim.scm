(define *gauche_modules-file* "./gauche_modules")
(define *template-file* "./scheme.vim.tmpl")

;;; load all modules
(use file.util)
(define (use-gauche_modules)
  (for-each
    (lambda (line)
      (with-error-handler
        (lambda (e)
          (warn (ref e 'message)))
        (lambda ()
          (eval `(use ,(string->symbol line)) (interaction-environment)))))
    (file->list read-line (expand-path *gauche_modules-file*))))


(define (is-r5rs? symbol)
  (with-error-handler
    (lambda (e) #f)
    (lambda ()
      (eval symbol (scheme-report-environment 5))
      #t)))


(define (is-module-name? symbol)
  (not (global-variable-bound? (current-module) symbol)))


(define (identify-to-type target)
  (let1 symbol (read-from-string target)
    (define (checker class)
      (eq? (eval `(class-of ,symbol) (interaction-environment)) class))
    (cond
      ((is-module-name? symbol) 'module)
      ((is-r5rs? symbol) #f)
      ((checker <syntax>) 'syntax)
      ((checker <macro>) 'macro)
      ((checker <procedure>) 'procedure)
      ((checker <generic>) 'method)
      ((checker <char-set>) 'char-set)
      ((checker <parameter>) 'parameter)
      ((let1 class (eval `(class-of ,symbol) (interaction-environment))
         (or
           (eq? class <class>)
           (#/\-meta\>$/ (symbol->string (class-name class)))))
       'class)
      (else #f))))


(use srfi-2)
(define (output-gauche-define)
  (let1 result-table (make-hash-table 'eq?)
    (define (print-label type)
      (print (format "    \" ~a" type)))
    (define (print-syntax target)
      (print (format "    syn keyword schemeExtSyntax ~a" target))
      (print (format "    set lispwords+=~a" target)))
    (define (print-func target)
      (print (format "    syn keyword schemeExtFunc ~a" target)))
    (define (print-result type printer)
      (print-label type)
      (for-each
        (lambda (target)
          (unless (#/^\|/ target)
            (printer target)))
        (sort (hash-table-get result-table type '())))
      (newline))

    (let loop ((line (read-line)))
      (if (eof-object? line)
        #t
        (begin
          (and-let* ((type (identify-to-type line)))
            (hash-table-push! result-table type line))
          (loop (read-line)))))
    (print-result 'module print-func)
    (print-result 'syntax print-syntax)
    (print-result 'macro print-syntax)
    (print-result 'procedure print-func)
    (print-result 'method print-func)
    (print-result 'class print-func)
    (print-result 'char-set print-func)
    (print-result 'parameter print-func)
    #t))


(define (main args)
  (use-gauche_modules)
  (when (< 1 (length args))
    (set! *gauche_modules-file* (cadr args)))
  (when (< 2 (length args))
    (set! *template-file* (caddr args)))
  (call-with-input-file
    *template-file*
    (lambda (template-port)
      (let loop ((line (read-line template-port)))
        (if (eof-object? line)
          #t
          (begin
            (if (#/##gauche-define##/ line)
              (output-gauche-define)
              (print line))
            (loop (read-line template-port)))))))
  0)

