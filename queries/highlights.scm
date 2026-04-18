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
  "=" @operator)

(raw_value) @string
