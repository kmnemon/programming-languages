package csp

import (
	"fmt"
	"testing"
	"time"
)

func TestHeartBeat(t *testing.T) {
	c := make(chan int)
	go func() {
		time.Sleep(10 * time.Second)
		for i := range 10 {
			c <- i
		}
	}()

	for item := range c {
		fmt.Println(item)
	}

}
