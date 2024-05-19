package generic

import "fmt"

func inspect[T any](value T) {
	fmt.Println(value)
}
