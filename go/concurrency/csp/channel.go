package csp

import (
	"bytes"
	"fmt"
	"os"
	"sync"
	"time"
)

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

// 7. one write channel with multiple read channel
func oneWriteAndMultipleReadChannel() {
	c := make(chan int)
	var wg sync.WaitGroup
	wg.Add(2)

	go func() {
		defer close(c)

		for i := range 10 {
			c <- i
		}

	}()

	go func() {
		defer wg.Done()
		for integer := range c {
			fmt.Println(integer)
		}
	}()

	go func() {
		defer wg.Done()
		for integer := range c {
			fmt.Println(integer)
		}
	}()

	wg.Wait()
}

// 8.
func BufferedChannel() {
	var stdoutBuff bytes.Buffer
	defer stdoutBuff.WriteTo(os.Stdout)
	intStream := make(chan int, 4)
	go func() {
		defer close(intStream)
		defer fmt.Fprintln(&stdoutBuff, "Producer Done.")
		for i := 0; i < 5; i++ {
			fmt.Fprintf(&stdoutBuff, "Sending: %d\n", i)
			intStream <- i
		}
	}()

	for integer := range intStream {
		fmt.Fprintf(&stdoutBuff, "Received %v.\n", integer)
	}
}

// 9.the owner of channel responsible for create, instantiate, close a channel
func channelOwner() {
	chanOwner := func() chan int {
		resultStream := make(chan int, 6)
		go func() {
			for i := 0; i <= 5; i++ {
				resultStream <- i
			}
		}()

		return resultStream
	}
	resultStream := chanOwner()

	time.Sleep(2 * time.Second)
	close(resultStream)

	for result := range resultStream {
		fmt.Printf("Received: %d\n", result)
	}
	fmt.Println("Done receiving!")
}
