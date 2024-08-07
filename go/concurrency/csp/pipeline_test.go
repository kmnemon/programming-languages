package csp

import (
	"fmt"
	"testing"
)

func TestPipeLine(t *testing.T) {
	var a any = 10

	stringStream := make(chan int)
	stringStream <- a.(int)

	fmt.Println(<-stringStream)
}
