package tree_sitter_yaml

// #cgo CFLAGS: -Isrc -std=c11 -fPIC
// #include "src/parser.c"
// #include "src/scanner.c"
import "C"

import "unsafe"

// Language returns the Tree-sitter language for YAML.
func Language() unsafe.Pointer {
	return unsafe.Pointer(C.tree_sitter_yaml())
}
