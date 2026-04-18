; queries/highlights.scm
; Tree-sitter highlights for taskwarrior (taskrc)

; Comments
(comment) @comment

; Include directives
(include_statement
  "include" @keyword
  (include_target) @string.special)

; Assignment structure
(assignment
  (key) @property
  "=" @operator)

(raw_value) @string

; Path-like values
((assignment
   key: (key) @property
   value: (value
     (raw_value) @string.special))
 (#match? @property "(^|\\.)location$"))

((assignment
   key: (key) @property
   value: (value
     (raw_value) @string.special))
 (#match? @string.special "^(~|/|\\.?/|\\$[A-Z_][A-Z0-9_]*)"))

; Numeric and version-like values
((assignment
   key: (key) @property
   value: (value
     (raw_value) @number))
 (#eq? @property "news.version")
 (#match? @number "^[0-9]+(?:\\.[0-9]+)+$"))

((assignment
   key: (key) @property
   value: (value
     (raw_value) @number))
 (#match? @property "(^holiday\\.[^.]+\\.(date|start|end)$|\\.coefficient$)")
 (#match? @number "^[0-9]+(?:\\.[0-9]+)?$"))

; Builtin scalar values
((assignment
   key: (key) @property
   value: (value
     (raw_value) @constant.builtin))
 (#match? @constant.builtin "^(on|off|yes|no|y|n|true|false|nothing|full|sparse|none|page|random)$"))

((assignment
   key: (key) @property
   value: (value
     (raw_value) @constant.builtin))
 (#match? @property "^holiday\\.[^.]+\\.date$")
 (#match? @constant.builtin "^(easter)$"))

; UDA type declarations
((assignment
   key: (key) @property
   value: (value
     (raw_value) @type.builtin))
 (#match? @property "^uda\\.[^.]+\\.type$")
 (#match? @type.builtin "^(string|numeric|uuid|date|duration)$"))
