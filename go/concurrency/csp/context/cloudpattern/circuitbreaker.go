package cloudpattern

import (
	"context"
	"errors"
	"fmt"
	"sync"
	"time"
)

/*
Circuit Breaker automatically degrades service functions in response to a likely fault,
preventing larger or cascading failures by eliminating recurring errors and providing
reasonable error responses.

if the fails exceed the threshold, the circuit breaker will open the circuit, and the call will fast fail.
*/

type Circuit func(context.Context) (string, error)

func Breaker(circuit Circuit, threshold int) Circuit {
	var failures int
	var last = time.Now()

	var m sync.RWMutex
	return func(ctx context.Context) (string, error) {
		m.RLock() // Establish a "read lock"
		d := failures - threshold
		if d >= 0 {
			shouldRetryAt := last.Add((2 << d) * time.Second)
			if !time.Now().After(shouldRetryAt) {
				m.RUnlock()
				return "", errors.New("service unavailable")
			}
		}
		m.RUnlock()                   // Release read `lock`
		response, err := circuit(ctx) // Issue the request proper
		m.Lock()
		defer m.Unlock()
		// Lock around shared resources
		last = time.Now() // Record time of attempt
		if err != nil {
			failures++
			return response, err // Circuit returned an error
		}
		failures = 0
		return response, nil
	}
}

// basic usage
func basicUsage() {
	// Create a circuit function that might fail
	unstableService := func(ctx context.Context) (string, error) {
		// Simulate a service that fails 50% of the time
		if time.Now().Unix()%2 == 0 {
			return "Success!", nil
		}
		return "", errors.New("service error")
	}

	// Wrap the circuit with a breaker (threshold of 3 failures)
	protectedService := Breaker(unstableService, 3)

	// Use the protected service
	ctx := context.Background()

	for i := 0; i < 10; i++ {
		result, err := protectedService(ctx)
		if err != nil {
			fmt.Printf("Attempt %d: Error - %v\n", i+1, err)
		} else {
			fmt.Printf("Attempt %d: Success - %s\n", i+1, result)
		}
		time.Sleep(500 * time.Millisecond)
	}
}
