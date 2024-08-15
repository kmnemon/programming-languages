package csp

import (
	"fmt"
	"testing"
	"time"

	"golang.org/x/time/rate"
)

func TestRatelimiter(t *testing.T) {
	fmt.Println(rate.NewLimiter(Per(2, time.Second), 1).Limit())
	fmt.Println(rate.NewLimiter(Per(10, time.Minute), 10).Limit())
}
