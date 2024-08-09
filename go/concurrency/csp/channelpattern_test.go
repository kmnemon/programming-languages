package csp

import (
	"fmt"
	"testing"
)

func TestChannelPattern(t *testing.T) {
	c := make(chan int, 1)
	go func() {

		c <- 1
		close(c)
		fmt.Println("closed")
	}()

	for i := range c {
		fmt.Println(i)
	}

}
