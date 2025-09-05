package context

import "testing"

func TestProcessEnter(t *testing.T) {
	ProcessEnter(NewContextWithTraceID())
}
