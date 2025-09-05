package cloudpattern

import (
	"context"
	"sync"
	"time"
)

/*
Debounce limits the frequency of a function invocation so that only the first or last in
a cluster of calls is actually performed.
*/

/*
1. function first - on each call of the outer function—regardless of its outcome—a time
interval is set. Any subsequent call made before that time interval expires is ignored;
any call made afterward is passed along to the inner function
*/

// type circuit func(context.Context) (string, error)

func DebounceFirst(circuit circuit, d time.Duration) circuit {
	var threshold time.Time
	var result string
	var err error
	var m sync.Mutex

	return func(ctx context.Context) (string, error) {
		m.Lock()
		defer m.Unlock()
		if time.Now().Before(threshold) {
			return result, err
		}
		result, err = circuit(ctx)
		threshold = time.Now().Add(d)
		return result, err
	}
}

func DebounceFirstContext(circuit circuit, d time.Duration) circuit {
	var threshold time.Time
	var m sync.Mutex
	var lastCtx context.Context
	var lastCancel context.CancelFunc

	return func(ctx context.Context) (string, error) {
		m.Lock()
		if time.Now().Before(threshold) {
			lastCancel()
		}
		lastCtx, lastCancel = context.WithCancel(ctx)
		threshold = time.Now().Add(d)
		m.Unlock()
		result, err := circuit(lastCtx)
		return result, err
	}
}

func basicUsage2() {
	// Create a circuit function that might fail
	service := func(ctx context.Context) (string, error) {
		// Simulate a service that returns success
		return "Success!", nil
	}

	// Wrap the circuit with a debounce (200 milliseconds)
	debouncedService := DebounceFirst(service, 200*time.Millisecond)

	// Use the debounced service
	ctx := context.Background()

	for i := 0; i < 10; i++ {
		result, err := debouncedService(ctx)
		if err != nil {
			println("Error:", err.Error())
		} else {
			println("Success:", result)
		}
		time.Sleep(50 * time.Millisecond) // Simulate rapid calls
	}
}

/*
2. function last - A function-last implementation will wait for a pause after a series of calls before call‐
ing the inner function. This variant is common in the JavaScript world when a pro‐
grammer wants a certain amount of input before making a function call, such as
when a search bar waits for a pause in typing before autocompleting. Function-last
tends to be less common in backend services because it doesn’t provide an immediate
response, but it can be useful if your function doesn’t need results right away.
*/

// type circuit func(context.Context) (string, error)

func DebounceLast(circuit circuit, d time.Duration) circuit {
	var m sync.Mutex
	var timer *time.Timer
	var cctx context.Context
	var cancel context.CancelFunc

	return func(ctx context.Context) (string, error) {
		m.Lock()
		if timer != nil {
			timer.Stop()
			cancel()
		}
		cctx, cancel = context.WithCancel(ctx)
		ch := make(chan struct {
			result string
			err    error
		}, 1)
		timer = time.AfterFunc(d, func() {
			r, e := circuit(cctx)
			ch <- struct {
				result string
				err    error
			}{r, e}
		})
		m.Unlock()
		select {
		case res := <-ch:
			return res.result, res.err
		case <-cctx.Done():
			return "", cctx.Err()
		}
	}
}
