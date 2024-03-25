package main

import "fmt"

type A struct {
	a *int
}

func main() {
	za := A{new(int)}
	zb := za

	*zb.a = 5

	fmt.Println(*za.a)

}
