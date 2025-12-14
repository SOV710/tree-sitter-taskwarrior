; queries/highlights.scm
; Tree-sitter highlights for taskwarrior (taskrc)

; -------------------------
; Comments
; -------------------------
(comment) @comment

; -------------------------
; Include directive
; -------------------------
(include_statement
  "include" @keyword
  (include_target) @string.special)

; -------------------------
; Assignments
; -------------------------
(assignment
  (key) @property
  "=" @operator
  (value) @string)

; -------------------------
; Values: quoted strings / atoms
; -------------------------
(quoted_string) @string

; bare atoms are “unquoted tokens” (paths, flags, words, etc.)
(bare_atom) @constant
(bare_item) @field

; -------------------------
; Comma-separated list: highlight each item and delimiters
; -------------------------
(comma_list
  (list_item (bare_item) @field))

(comma_list
  (list_item (quoted_string) @string))
  
"," @punctuation.delimiter
