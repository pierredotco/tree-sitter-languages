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

Each package exposes:

```go
func Language() unsafe.Pointer
```

Use the returned pointer with a Tree-sitter Go binding that accepts raw
language pointers.
