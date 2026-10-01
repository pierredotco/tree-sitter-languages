# tree-sitter-languages

Go bindings for vendored Tree-sitter languages.

## Packages

| Grammar    | Import path                                          |
| ---------- | ---------------------------------------------------- |
| Dockerfile | `pierre.co/pierre/tree-sitter-languages/dockerfile` |
| GraphQL    | `pierre.co/pierre/tree-sitter-languages/graphql`    |
| Make       | `pierre.co/pierre/tree-sitter-languages/make`       |
| Nix        | `pierre.co/pierre/tree-sitter-languages/nix`        |
| Svelte     | `pierre.co/pierre/tree-sitter-languages/svelte`     |
| Vue        | `pierre.co/pierre/tree-sitter-languages/vue`        |
| YAML       | `pierre.co/pierre/tree-sitter-languages/yaml`       |

## Query assets

The JavaScript, TypeScript, and TSX highlight queries are generated MIT-licensed
assets. Original rules and token classifications are derived from the TypeScript
and TSX grammars in `zed-industries/tree-sitter-typescript` at
`v0.0.0-20251004050342-e2c53597d6a5`. Selected rules are copied or adapted from
these MIT upstream files:

- `tree-sitter/tree-sitter-javascript@v0.25.0/queries/highlights.scm`
- `tree-sitter/tree-sitter-javascript@v0.25.0/queries/highlights-jsx.scm`
- `zed-industries/tree-sitter-typescript@e2c53597d6a5/queries/highlights.scm`

Their unmodified licenses, including copyright notices, are in
`licenses/tree-sitter-javascript/LICENSE` and
`licenses/tree-sitter-typescript/LICENSE`. Original additions use the root
`LICENSE`. No editor query files are used as sources.

Run the generator from this repository's root:

```sh
go run ./cmd/genkeywords
go run ./cmd/genkeywords -check
go run ./cmd/genkeywords -list
```

It downloads both pinned `node-types.json` files and verifies their SHA-256
hashes. For offline use, pass `-grammar-dir <directory>` containing
`typescript-node-types.json` and `tsx-node-types.json`; the same hashes apply.
`-list` prints every anonymous token, including intentionally uncaptured tokens.
`queries/tokens.json` assigns every token either a capture or a written reason
for no standalone capture. Missing, stale, and invalid classifications fail.

The outputs are self-contained:

- `typescript/queries/highlights.scm`: anonymous tokens + `queries/common.scm`
  + `queries/typescript.scm` + generated shorthand-parameter patterns.
- `tsx/queries/highlights.scm`: anonymous tokens + common + TypeScript
  + `queries/jsx.scm`.
- `javascript/queries/highlights.scm`: byte-identical to TSX, because its consumer
  uses the TSX parser for JavaScript and JSX as well.

The generator preserves fragment order. Multiple captures on one node are
intentional. Only literal/text/comment nodes use `string`, `text`, or `comment`
captures; template substitutions and JSX expressions use `embedded`. These
distinctions preserve literal-content ownership during syntax-aware diffs.

Shorthand parameter bindings use generated structural paths because Tree-sitter
queries have no unbounded ancestor matching. `maxParameterPatternDepth = 4` in
the generator counts object, array, pair-value, assignment (including object
defaults), and rest pattern nodes together between the parameter and shorthand.
For example, `{ outer: { item } }` uses three nodes (object, pair, object).
The binding edges exclude default-value expressions and computed keys.
Bindings deeper than the limit retain only `variable`, as do shorthand
bindings outside parameters.

Type-only import rules capture both the imported identifier (`name`) and any
local binding identifier (`alias`); a quoted imported name remains a string.

The remaining highlight queries are vendored from each grammar's upstream
repository, under `<language>/queries/highlights.scm`:

| Query      | Source                                                                 |
| ---------- | ---------------------------------------------------------------------- |
| Dockerfile | `camdencheek/tree-sitter-dockerfile@v0.2.0`                             |
| GraphQL    | `bkegley/tree-sitter-graphql@v0.0.0-20210510140929-5e66e961eee4`        |
| Make       | `alemuller/tree-sitter-make@v0.0.0-20211216171417-a4b9187417d6`         |
| Nix        | `nix-community/tree-sitter-nix@v0.3.0`                                  |
| Svelte     | `Himujjal/tree-sitter-svelte@v0.11.0`                                   |
| Vue        | `tree-sitter-grammars/tree-sitter-vue@v0.0.0-20260124095733-ce8011a414fd` |
| YAML       | `zed-industries/tree-sitter-yaml@v0.0.0-20240911205050-baff0b51c64e`    |

Each vendored grammar package includes its own unmodified upstream `LICENSE`,
fetched at the ref in the table above. Those files govern the vendored grammar
sources and queries, independently of this repository's root license.

## TypeScript-family rule provenance

Rule IDs appear in fragment comments; alternatives within one rule share its ID.
`JS` means the pinned JavaScript `queries/highlights.scm`, `JSX` means its
`queries/highlights-jsx.scm`, and `TS` means the pinned TypeScript
`queries/highlights.scm` listed above. “Grammar” means newly authored from the
pinned TypeScript/TSX `src/node-types.json` and `src/grammar.json`.
Whitespace/layout changes to copied MIT rules are not semantic adaptations.

| Rule | Purpose | Source |
| --- | --- | --- |
| Every token-table entry | Anonymous keyword, operator, punctuation, or contextual omission | Grammar |
| C01 | Function-expression name | JS, copied |
| C02 | Function-declaration name | JS, copied |
| C03 | Method-definition name | JS, copied |
| C04 | Function-valued object property | JS, copied |
| C05 | Function assigned to member | JS, copied |
| C06 | Function-valued variable | JS, copied |
| C07 | Function assigned to identifier | JS, copied |
| C08 | Direct call target | JS, copied |
| C09 | Member call target | JS, copied |
| C10 | Generator-expression name | Grammar |
| C11 | Generator-declaration name | Grammar |
| C12 | Private method definition | Grammar |
| C13 | Private method call | Grammar |
| C14 | Base identifier | JS, copied |
| C15 | Base property identifier | JS, copied |
| C16 | Shorthand property references/bindings | Grammar |
| C17 | Private property identifier | Grammar |
| C18 | Object property name | Grammar |
| C19 | Object-pattern property name | Grammar |
| C20 | Class field name | Grammar |
| C21 | Direct constructor reference | Grammar |
| C22 | Member constructor reference | Grammar |
| C23 | Constructor method name | Grammar |
| C24 | Uppercase constant identifiers | JS, adapted RE2 constant-name predicate |
| C25 | This, super and meta-properties | JS, adapted capture and meta-property alternative |
| C26 | Null and undefined | JS, split from boolean alternatives |
| C27 | Bare arrow parameter | Grammar |
| C28 | Catch parameter | Grammar |
| C29 | Rest parameter binding | Grammar |
| C30 | Bare decorator reference | Grammar |
| C31 | Unary void keyword | Grammar |
| C32 | Comment | JS, copied |
| C33 | String/template literal | JS, copied |
| C34 | Number literal | JS, copied |
| C35 | Template substitution and delimiters | JS, copied |
| C36 | Boolean literals | JS, split alternatives and adapted capture |
| C37 | Escape sequence | Grammar |
| C38 | Regular-expression literal | JS, adapted capture |
| C39 | Regular-expression flags | Grammar |
| C40 | Interpreter directive | Grammar |
| T01 | Type identifier | TS, copied |
| T02 | Predefined type | TS, copied |
| T03 | Type-argument brackets | TS, copied |
| T04 | Required parameter binding fields, excluding defaults | Grammar |
| T05 | Optional parameter binding fields, excluding defaults | Grammar |
| T06 | Function signature name | Grammar |
| T07 | Method signature name | Grammar |
| T08 | Abstract method signature name | Grammar |
| T09 | Property signature name | Grammar |
| T10 | Class-expression name | Grammar |
| T11 | Class-declaration name | Grammar |
| T12 | Abstract class name | Grammar |
| T13 | Alias, interface and enum declaration names | Grammar |
| T14 | Type parameter name | Grammar |
| T15 | Enum member name | Grammar |
| T16 | Namespace name | Grammar |
| T17 | Type-parameter brackets | Grammar |
| T18 | Mapped optionality modifiers | Grammar |
| T19 | Template literal type | Grammar |
| T20 | Template type substitution and delimiters | Grammar |
| T21 | Index-signature parameter name | Grammar |
| T22 | Names and aliases in statement-level named type-only imports | Grammar |
| T23 | Names and aliases in inline type-only import specifiers | Grammar |
| T24 | Default type-only import binding | Grammar |
| T25 | Namespace type-only import binding | Grammar |
| T26 | Type-only require import binding | Grammar |
| T27 | Generated shorthand parameter bindings; maximum four combined object/array/pair-value/assignment/rest pattern nodes, then variable-only fallback | Grammar |
| J01 | Intrinsic opening tag | JSX, adapted name field, predicate and capture |
| J02 | Intrinsic closing tag | JSX, adapted name field, predicate and capture |
| J03 | Intrinsic self-closing tag | JSX, adapted name field, predicate and capture |
| J04 | Component opening tag | Grammar |
| J05 | Component closing tag | Grammar |
| J06 | Component self-closing tag | Grammar |
| J07 | Namespaced tag names | Grammar |
| J08 | Attribute name | JSX, adapted capture and namespaced alternative |
| J09 | Namespace separator | Grammar |
| J10 | Opening/fragment delimiters | JSX, adapted capture |
| J11 | Closing/fragment delimiters | JSX, adapted capture |
| J12 | Self-closing delimiters | JSX, adapted capture |
| J13 | JSX expression and delimiters | Grammar |
| J14 | JSX text | Grammar |
| J15 | HTML character reference | Grammar |
| J16 | HTML comment | Grammar |

## Retracted releases

Versions `v0.1.0` through `v0.2.0` are retracted because their highlight query
sources are incompatible or unverified. Do not reuse `v0.2.0`: it is already
recorded in the Go checksum database. A release of this replacement must use
`v0.3.0` or later and follow an independent provenance audit.

Each package exposes:

```go
func Language() unsafe.Pointer
```

Use the returned pointer with a Tree-sitter Go binding that accepts raw
language pointers.
