package basic

import "fmt"

func switchCase1() {
	var s string = "hello"

	switch s {
	case "hello":
		fmt.Println("found hello")
	case "world":
		fmt.Println("found world")
	default:
		fmt.Println("found others")
	}
}
