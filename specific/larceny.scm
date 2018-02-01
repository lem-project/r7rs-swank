(define ($scheme-name)
  "larceny")
(define ($all-package-names)
  '())

(define $make-hash-table make-hash-table)
(define $hash-table/get hash-table-ref/default)
(define $hash-table/put! hash-table-set!)
(define $hash-table/count hash-table-size)
(define ($error-description error)
  (let ((o (open-output-string)))
    (display error o)
    (get-output-string o)))

(define ($open-tcp-server/accept port-number handler)
  (let ((s (make-server-socket port-number 'blocking)))
    (let-values (((ns addr) (server-socket-accept s)))
      (let ((in (socket-input-port ns 'blocking 'char))
            (out (socket-output-port ns 'blocking 'char 'flush)))
        (handler port-number in out)))))

(define ($output-to-repl thunk)
  ;; basic implementation, print all output at the end, this should
  ;; be replaced with a custom output port
  (let ((o (open-output-string)))
    (parameterize ((current-output-port o))
      (let-values ((x (thunk)))
        (swank/write-string (get-output-string o) #f)
        (apply values x)))))

(define ($completions prefix env-name)
  (cons '()
        prefix))

(define ($function-parameters-and-documentation name)
  (cons #f #f))

(define ($set-package name)
  (list "(user)" "(user)"))

(define ($environment name)
  (interaction-environment))

(define ($condition-trace condition)
  '())

(define ($frame-locals-and-catch-tags nr)
  '())

(define ($frame-var-value frame index)
  #f)

(define ($condition-msg condition)
  "UNKNOWN")

(define ($condition-links condition)
  '())

(define ($handle-condition exception)
  #f)

(define $pretty-print pretty-print)

(define-record-type <istate>
  (make-istate object parts next previous content)
  istate?
  (object istate-object)
  (parts istate-parts)
  (next istate-next set-istate-next!)
  (previous istate-previous)
  (content istate-content))

(define ($inspect-fallback object)
  #f)
