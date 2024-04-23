package concurrency

import "testing"

func TestProcessEnter(t *testing.T) {
	ProcessEnter(NewContextWithTraceID())
}
