; Common structural rules. Rule IDs are mapped to sources in README.md.

; C01-C09: MIT tree-sitter-javascript queries/highlights.scm, function rules.
(function_expression name: (identifier) @function)
(function_declaration name: (identifier) @function)
(method_definition name: (property_identifier) @function.method)
(pair key: (property_identifier) @function.method value: [(function_expression) (arrow_function)])
(assignment_expression left: (member_expression property: (property_identifier) @function.method) right: [(function_expression) (arrow_function)])
(variable_declarator name: (identifier) @function value: [(function_expression) (arrow_function)])
(assignment_expression left: (identifier) @function right: [(function_expression) (arrow_function)])
(call_expression function: (identifier) @function)
(call_expression function: (member_expression property: (property_identifier) @function.method))

; C10-C13: grammar-derived generator functions and private methods.
(generator_function name: (identifier) @function)
(generator_function_declaration name: (identifier) @function)
(method_definition name: (private_property_identifier) @function.method)
(call_expression function: (member_expression property: (private_property_identifier) @function.method))

; C14-C15: MIT tree-sitter-javascript queries/highlights.scm, base identifiers.
(identifier) @variable
(property_identifier) @property

; C16-C20: grammar-derived shorthand, private and declared properties.
[(shorthand_property_identifier) (shorthand_property_identifier_pattern)] @variable
(private_property_identifier) @property
(pair key: (property_identifier) @property.name)
(pair_pattern key: (property_identifier) @property.name)
(public_field_definition name: [(property_identifier) (private_property_identifier)] @property.name)

; C21-C23: grammar-derived constructor positions.
(new_expression constructor: (identifier) @constructor)
(new_expression constructor: (member_expression property: (property_identifier) @constructor))
((method_definition name: (property_identifier) @constructor) (#eq? @constructor "constructor"))
; C24-C26: MIT highlights.scm adapted constant predicate, special variables and nulls.
([(identifier) (shorthand_property_identifier) (shorthand_property_identifier_pattern)] @constant
  (#match? @constant "^[A-Z][A-Z0-9_]*$"))
[(this) (super) (meta_property)] @variable.special
[(null) (undefined)] @constant.builtin

; C27-C29: grammar-derived parameter positions, including rest bindings.
(arrow_function parameter: (identifier) @variable.parameter)
(catch_clause parameter: (identifier) @variable.parameter)
(required_parameter (rest_pattern (identifier) @variable.parameter))

; C30-C31: grammar-derived decorators and unary void.
(decorator (identifier) @function)
(unary_expression operator: "void" @keyword)

; C32-C35: MIT tree-sitter-javascript queries/highlights.scm, literals and templates.
(comment) @comment
[(string) (template_string)] @string
(number) @number
(template_substitution "${" @punctuation.special "}" @punctuation.special) @embedded

; C36, C38: MIT highlights.scm adapted literal captures; C37, C39-C40: grammar-derived.
[(true) (false)] @boolean
(escape_sequence) @string.escape
(regex) @string.regex
(regex_flags) @keyword.operator.regex
(hash_bang_line) @comment
