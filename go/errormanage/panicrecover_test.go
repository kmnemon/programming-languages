package errormanage

import (
	"testing"
)

func TestPanic(t *testing.T) {
	callThePanic()
}

func TestRecover(t *testing.T) {
	callThePanicAndRecover()
}
