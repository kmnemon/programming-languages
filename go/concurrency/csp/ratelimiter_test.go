package csp

import (
	"fmt"
	"testing"
)

func TestRatelimiter(t *testing.T) {
	var fib func(n int) <-chan int
	fib = func(n int) <-chan int {
		result := make(chan int)
		go func() {
			defer close(result)
			if n <= 2 {
				result <- 1
				return
			}
			result <- <-fib(n-1) + <-fib(n-2)
		}()
		return result
	}
	fmt.Printf("fib(4) = %d", <-fib(4))
}
