package concurrency

import "fmt"

// 1.done
func doneChannel() {
	done := make(chan struct{})

	go func() {
		fmt.Println("gorountine run~")
		done <- struct{}{}
	}()

	<-done
	fmt.Println("all goroutine finished")
}

// 2.pipeline
func pipeline() {
	naturals := make(chan int)
	squares := make(chan int)
	// Counter
	go func() {
		for x := 0; x < 100; x++ {
			naturals <- x
		}
		close(naturals)
	}()
	// Squarer
	go func() {
		for x := range naturals {
			squares <- x * x
		}
		close(squares)
	}()
	// Printer (in main goroutine)
	for {
		fmt.Println(<-squares)
	}
}

//3.unidirectional channel types

func counter(out chan<- int) {
	for x := 0; x < 100; x++ {
		out <- x
	}
	close(out)
}

func squarer(out chan<- int, in <-chan int) {
	for v := range in {
		out <- v * v
	}
	close(out)
}

func printer(in <-chan int) {
	for v := range in {
		fmt.Println(v)
	}
}

func unidirectional() {
	naturals := make(chan int)
	squares := make(chan int)
	go counter(naturals)
	go squarer(squares, naturals)
	printer(squares)
}

// 4.buffered channl
func buffered() {
	ch := make(chan string, 3)
	close(ch)
}

// 5. Multiplexing with select
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

// 6. Cancelled
var done = make(chan struct{})

func cancelled() bool {
	select {
	case <-done:
		return true
	default:
		return false
	}
}
