package basic

import (
	"cmp"
	"errors"
	"fmt"
	"iter"
)

// 1. basic range
func basicRange() {
	var arr []string = make([]string, 0)
	for i, s := range arr {
		fmt.Println(i)
		fmt.Println(s)
	}
}

// 2 range over digital
func rangeOverDigital() {
	for i := range 10 {
		fmt.Println(i)
	}
}

// 3. range over function
type node[T any] struct {
	value T
	next  *node[T]
}

type Stack[T any] struct {
	head *node[T]
}

func (s *Stack[T]) Push(v T) {
	s.head = &node[T]{v, s.head}
}

var ErrEmpty = errors.New("empty stack")

func (s *Stack[T]) Pop() (T, error) {
	if s.head == nil {
		var v T
		return v, ErrEmpty
	}

	n := s.head
	s.head = s.head.next
	return n.value, nil
}

//1. type Seq[V any] func(yield func(V) bool)
//2. type Seq2[K, V any] func(yield func(K, V) bool)

// a. yield func(func(T) bool)
func (s *Stack[T]) Iter() func(func(T) bool) {
	iter := func(yield func(T) bool) {
		for n := s.head; n != nil; n = n.next {
			if !yield(n.value) {
				return
			}
		}
	}

	return iter
}

func (s *Stack[T]) rangeOverFunction1() {
	for v := range s.Iter() {
		fmt.Println(v)
	}
}

// b. yield  func(func(int, T) bool)
func (s *Stack[T]) Iter2() func(func(int, T) bool) {
	iter := func(yield func(int, T) bool) {
		for i, n := 0, s.head; n != nil; i, n = i+1, n.next {
			if !yield(i, n.value) {
				return
			}
		}
	}

	return iter
}

func (s *Stack[T]) rangeOverFunction2() {
	for i, v := range s.Iter2() {
		fmt.Println(i, v)
	}
}

//3. func Pull[V any](seq Seq[V]) (next func() (V, bool), stop func())
//4. func Pull2[K, V any](seq Seq2[K, V]) (next func() (K, V, bool), stop func())

/*These pull functions are passed a Seq value and return a next and stop function.
The next function is used to pull the next value from Seq and stop is used to force
the iteration to stop. The stop function works by passing a yield function
that returns false at the next iteration.*/

// One example of why we might need these functions is if we wanted to find the max value
// currently stored in the stack.
// Remember, we don’t know the length of the stack (and it could potentially be infinite)
// and we can’t index directly into the stack.
func Max[T cmp.Ordered](seq iter.Seq[T]) (T, error) {
	pull, stop := iter.Pull(seq)
	defer stop()

	max, ok := pull()
	if !ok {
		return max, fmt.Errorf("Max of empty sequence")
	}

	for v, ok := pull(); ok; v, ok = pull() {
		if v > max {
			max = v
		}
	}

	return max, nil
}

// func (s *Stack[T]) findMax() {
// 	m, err := Max(s.Iter())
// 	if err != nil {
// 		fmt.Println("ERROR:", err)
// 	} else {
// 		fmt.Println("max:", m)
// 	}
// }
