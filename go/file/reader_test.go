package file

import (
	"strings"
	"testing"
)

func TestCountEmptyLines(t *testing.T) {
	emptyLines, _ := countEmptyLines(strings.NewReader(
		`foo
		    bar
			baz
		`,
	))

	if emptyLines != 1 {
		t.Error("CountEmptyLines failed")
	}
}
