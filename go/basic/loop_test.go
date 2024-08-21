package basic

import "testing"

func TestLoop(t *testing.T) {
	s := Stack[int]{}
	s.Push(1)
	s.Push(3)
	s.Push(4)
	s.Push(2)
	s.rangeOverFunction2()
}
