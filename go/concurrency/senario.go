package concurrency

import "time"

/*
Senario 1: Parallel
*/
func taskA() int {
	time.Sleep(2 * time.Second)
	return 5
}

func parallelExample() int {
	c := make(chan int)

	go func() {
		c <- taskA()
	}()
	go func() {
		c <- taskA()
	}()

	r1 := <-c
	r2 := <-c

	return r1 + r2
}

/*
Senario 2: Concurrent
*/
func taskA1() int {
	time.Sleep(2 * time.Second)
	return 5
}
func taskB1(a1 int) int {
	time.Sleep(1 * time.Second)
	return a1 + 2
}

func concurrentExample() int {
	c := make(chan int, 3)

	rc := make(chan int)

	go func() {
		for range 5 {
			c <- taskA1()
		}
	}()

	go func() {
		for range 5 {
			r1 := <-c
			rc <- taskB1(r1)
		}
	}()

	result := 0
	for range 5 {
		result += <-rc
	}
	return result
}

/*
Senario 3: first Parallel, then Concurrent
*/
func taskA2() int {
	time.Sleep(2 * time.Second)
	return 5
}
func taskB2(a1 int) int {
	time.Sleep(1 * time.Second)
	return a1 + 2
}

func parallelWithConcurrentExample() int {
	c := make(chan int, 3)

	rc := make(chan int)

	go func() {
		for range 5 {
			c <- taskA1()
		}
	}()

	go func() {
		for range 5 {
			c <- taskA1()
		}
	}()

	go func() {
		for range 10 {
			r1 := <-c
			rc <- taskB1(r1)
		}
	}()

	result := 0
	for range 10 {
		result += <-rc
	}
	return result
}
