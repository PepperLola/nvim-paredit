(list
  (symbol) @fn-name
  (#any-of? @fn-name
    "let"
    "let*"
    "letrec"
    "parameterize"
    "with-handlers"
    "when"
    "unless"
    "begin"
    "for"
    "for/list"
    "for/fold"
    "for/hash"
    "with-input-from-file"
    "with-output-to-file")

  (list
    (_) @pair))

(list
  (symbol) @fn-name
  (#eq? @fn-name "cond")
  ((_) @pair (_) @pair)+)
