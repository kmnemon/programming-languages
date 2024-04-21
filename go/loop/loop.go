package loop

import "fmt"

func loop1() {
	var pow = []int{1, 2, 4, 8, 16, 32, 64, 128}

	for i, v := range pow {
		fmt.Printf("2**%d = %d\n", i, v)
	}
}

func loop2() {
	for i := range 10 {
		fmt.Println(i)
	}
}
