// grammar.js
module.exports = grammar({
  name: "taskwarrior",

  extras: (_$) => [/[ \t]+/],

  rules: {
    source_file: ($) =>
      seq(
        repeat(choice($._terminated_statement, $._terminated_comment, $._blank_line)),
        optional(choice($._statement_with_comment, $.comment)),
      ),

    _statement: ($) => choice($.include_statement, $.assignment),

    _statement_with_comment: ($) => seq($._statement, optional($.comment)),
    _terminated_statement: ($) => seq($._statement_with_comment, $._newline),
    _terminated_comment: ($) => seq($.comment, $._newline),
    _blank_line: ($) => $._newline,

    include_statement: ($) => seq("include", field("target", $.include_target)),

    include_target: (_$) => token(/[^\s\r\n#]+/),

    assignment: ($) => seq(field("key", $.key), "=", optional(field("value", $.value))),

    key: (_$) => token(/[A-Za-z_][A-Za-z0-9_.-]*/),

    value: ($) => $.raw_value,
    raw_value: (_$) => token(/[^\s\r\n#][^\r\n#]*/),

    comment: (_$) => token(seq("#", /[^\r\n]*/)),
    _newline: (_$) => /\r?\n/,
  },
});
