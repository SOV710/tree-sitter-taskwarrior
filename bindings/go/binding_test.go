package tree_sitter_taskwarrior_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_taskwarrior "github.com/sov710/tree-sitter-taskwarrior/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_taskwarrior.Language())
	if language == nil {
		t.Errorf("Error loading Taskwarrior grammar")
	}
}
