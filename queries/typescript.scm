; TypeScript structural rules; also used for JS because sema uses the TSX parser.

; T01-T03: MIT tree-sitter-typescript queries/highlights.scm.
(type_identifier) @type
(predefined_type) @type.builtin
(type_arguments "<" @punctuation.bracket ">" @punctuation.bracket)

; T04-T05: grammar-derived binding fields exclude default-value expressions.
[(required_parameter pattern: (identifier) @variable.parameter)
 (required_parameter name: (identifier) @variable.parameter)]
[(optional_parameter pattern: (identifier) @variable.parameter)
 (optional_parameter name: (identifier) @variable.parameter)]

; T06-T09: grammar-derived names in signatures and field declarations.
(function_signature name: (identifier) @function)
(method_signature name: [(property_identifier) (private_property_identifier)] @function.method)
(abstract_method_signature name: [(property_identifier) (private_property_identifier)] @function.method)
(property_signature name: [(property_identifier) (private_property_identifier)] @property.name)

; T10-T16: grammar-derived class, type, enum and namespace declarations.
(class name: (type_identifier) @type.class)
(class_declaration name: (type_identifier) @type.class)
(abstract_class_declaration name: (type_identifier) @type.class)
[(type_alias_declaration name: (type_identifier) @type.name)
 (interface_declaration name: (type_identifier) @type.name)
 (enum_declaration name: (identifier) @type.name)]
(type_parameter name: (type_identifier) @type.name)
(enum_assignment name: (property_identifier) @constant)
(internal_module name: [(identifier) (nested_identifier)] @nested)

; T17-T20: grammar-derived type delimiters, mapped modifiers and template types.
(type_parameters "<" @punctuation.bracket ">" @punctuation.bracket)
["+?:" "-?:" "?:"] @operator
(template_literal_type) @string
(template_type "${" @punctuation.special "}" @punctuation.special) @embedded

; T21: grammar-derived index-signature binding (not its index or value type).
(index_signature name: (identifier) @variable.parameter)

; T22-T26: grammar-derived type-only imports.
; import_specifier.name is the exported name; alias, when present, is the local binding.
; Both identifier names denote types, while a quoted export name remains a string.
(import_statement "type" (import_clause (named_imports (import_specifier (identifier) @type))))
(import_specifier "type" (identifier) @type)
(import_statement "type" (import_clause (identifier) @type))
(import_statement "type" (import_clause (namespace_import (identifier) @type)))
(import_statement "type" (import_require_clause (identifier) @type))
