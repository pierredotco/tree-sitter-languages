package tree_sitter_graphql

// #cgo CFLAGS: -Isrc -std=c11 -fPIC
// #include "src/parser.c"
import "C"

import "unsafe"

// Language returns the Tree-sitter language for this grammar.
func Language() unsafe.Pointer {
	return unsafe.Pointer(C.tree_sitter_graphql())
}
