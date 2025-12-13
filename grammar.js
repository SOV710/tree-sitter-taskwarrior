// grammar.js
module.exports = grammar({
  name: "taskwarrior",

  extras: ($) => [/[ \t]+/],

  rules: {
    source_file: ($) =>
      seq(repeat($._line), optional(choice($._statement, $.comment_line))),

    _line: ($) =>
      choice(
        seq($._statement, $.newline),
        seq($.comment_line, $.newline),
        $.newline,
      ),

    _statement: ($) => choice($.include_statement, $.assignment),

    comment_line: ($) => $.comment,

    include_statement: ($) => seq("include", field("target", $.include_target)),

    include_target: (_$) => token(/[^\s\r\n#]+/),

    assignment: ($) => seq(field("key", $.key), "=", field("value", $.value)),

    key: (_$) => token(/[A-Za-z_][A-Za-z0-9_.-]*/),

    value: ($) => choice($.comma_list, $.atom_list),

    comma_list: ($) =>
      seq(
        field("item", $.list_item),
        ",",
        field("item", $.list_item),
        repeat(seq(",", field("item", $.list_item))),
      ),

    atom_list: ($) => repeat1($.value_atom),

    list_item: ($) => choice($.quoted_string, $.bare_item),
    value_atom: ($) => choice($.quoted_string, $.bare_atom),

    quoted_string: (_$) =>
      token(seq('"', repeat(choice(/[^"\\\r\n]/, /\\./)), '"')),

    bare_atom: (_$) => token(/[^\s,\r\n#]+/),
    bare_item: (_$) => token(/[^\s,\r\n#]+/),

    comment: (_$) => token(seq("#", /[^\r\n]*/)),
    newline: (_$) => /\r?\n/,
  },
});
