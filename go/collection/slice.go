package collection

import "fmt"

func sliceWithArray() {
	var arr [5]int = [5]int{10, 20, 30, 40, 50}

	slice := arr[1:4]

	fmt.Println(slice[0])
}
