package memorysyn

import (
	"fmt"
	"sync"
)

func waitGroup() {
	var wg sync.WaitGroup

	for i := 1; i < 5; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			fmt.Println("go run")
		}()
	}

	wg.Wait()
	fmt.Println("all done")
}
