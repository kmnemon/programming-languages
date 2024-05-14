package basic

import "fmt"

func loop1() {
	var arr []string = make([]string, 0)
	for i, s := range arr {
		fmt.Println(i)
		fmt.Println(s)
	}
}
