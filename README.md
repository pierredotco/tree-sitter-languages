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

The JavaScript, TypeScript, and TSX highlight queries are vendored from
`zed-industries/zed` at commit `8ba35e5eacf30a847140e82eced017f93f3f6df0`.
They live next to their language names under:

- `javascript/queries/highlights.scm`
- `typescript/queries/highlights.scm`
- `tsx/queries/highlights.scm`

Each package exposes:

```go
func Language() unsafe.Pointer
```

Use the returned pointer with a Tree-sitter Go binding that accepts raw
language pointers.
