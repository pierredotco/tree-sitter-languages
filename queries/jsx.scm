; JSX rules; rule IDs map to sources in README.md.
; Lowercase and namespaced tags denote intrinsic elements; other names are components.

; J01-J03: MIT highlights-jsx.scm adapted to grammar name fields and capture vocabulary.
((jsx_opening_element name: (identifier) @tag.jsx) (#match? @tag.jsx "^[a-z]"))
((jsx_closing_element name: (identifier) @tag.jsx) (#match? @tag.jsx "^[a-z]"))
((jsx_self_closing_element name: (identifier) @tag.jsx) (#match? @tag.jsx "^[a-z]"))

; J04-J06: component names, including member paths.
(jsx_opening_element name: [(identifier) (member_expression)] @tag.component.jsx
  (#not-match? @tag.component.jsx "^[a-z][^.]*$"))
(jsx_closing_element name: [(identifier) (member_expression)] @tag.component.jsx
  (#not-match? @tag.component.jsx "^[a-z][^.]*$"))
(jsx_self_closing_element name: [(identifier) (member_expression)] @tag.component.jsx
  (#not-match? @tag.component.jsx "^[a-z][^.]*$"))

; J07, J09: grammar-derived namespaces; J08 adapts MIT highlights-jsx.scm attributes.
[(jsx_opening_element name: (jsx_namespace_name) @tag.jsx)
 (jsx_closing_element name: (jsx_namespace_name) @tag.jsx)
 (jsx_self_closing_element name: (jsx_namespace_name) @tag.jsx)]
(jsx_attribute [(property_identifier) (jsx_namespace_name)] @attribute.jsx)
(jsx_namespace_name ":" @punctuation.delimiter.jsx)

; J10-J12: MIT highlights-jsx.scm adapted to JSX-specific captures; J13: grammar-derived.
(jsx_opening_element ["<" ">"] @punctuation.bracket.jsx)
(jsx_closing_element ["</" ">"] @punctuation.bracket.jsx)
(jsx_self_closing_element ["<" "/>"] @punctuation.bracket.jsx)
(jsx_expression "{" @punctuation.special "}" @punctuation.special) @embedded

; J14-J16: literal JSX text, entities and comments.
(jsx_text) @text.jsx
(html_character_reference) @string.special
(html_comment) @comment
