package basic

import (
	"fmt"
	"testing"
)

func TestLoop(t *testing.T) {
	s := Stack[int]{}
	s.Push(1)
	s.Push(3)
	s.Push(4)
	s.Push(2)
	s.rangeOverFunction2()
}

type AA struct {
	a map[int]string
}

func TestFloat(t *testing.T) {
	m := []int{1, 2, 3}
	for i := range m {
		m = append(m, i)

	}
	fmt.Println(m)

}
