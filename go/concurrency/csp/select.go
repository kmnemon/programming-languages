package csp

import (
	"fmt"
	"time"
)

//1.Multiplexing with select
/*
1.select blocks until one of its cases can proceed.
2.If multiple cases are ready, one is chosen at random.
3.A default case, if present, executes immediately if no other case is ready.
*/
func multiplexSelect() {
	ch := make(chan int, 1)
	for i := 0; i < 10; i++ {
		select {
		case x := <-ch:
			fmt.Println(x) // "0" "2" "4" "6" "8"
		case ch <- i:
		}
	}
}

// 2.timeout
func selectTimeout() {
	var c <-chan int
	select {
	case <-c:
	case <-time.After(1 * time.Second):
		fmt.Println("Timed out.")
	}
}

// 3. default select
func defaultSelect() {
	start := time.Now()
	var c1, c2 <-chan int

	select {
	case <-c1:
	case <-c2:
	default:
		fmt.Printf("In default after %v\n\n", time.Since(start))
	}
}
