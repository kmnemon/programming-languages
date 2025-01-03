package concurrency

import (
	"fmt"
	"sync"
)

func workpooling() (int, error) {
	var count int64
	wg := sync.WaitGroup{}
	var n = 10

	ch := make(chan []byte, n)

	//worker pooling
	wg.Add(n)
	for i := 0; i < n; i++ {
		go func() {
			defer wg.Done()
			for b := range ch {
				// do some tasks
				// v := task(b)
				// atomic.AddInt64(&count, int64(v))
				fmt.Println(b)
			}

		}()
	}
	for range 30 {
		b := make([]byte, 1024)
		// Read from r to b
		ch <- b
	}
	close(ch)
	wg.Wait()
	return int(count), nil

}
