package classes

import "fmt"

type Fighter interface {
	init()
}

type XWing struct{}

func (x XWing) init() {}

type YWing struct{}

func (y YWing) init() {}

func lanchXFighter() Fighter {
	return XWing{}
}

func lanchYFighter() Fighter {
	return YWing{}
}

func compareFighter() {
	x := lanchXFighter()
	x1 := lanchXFighter()
	y := lanchYFighter()

	if x == x1 {
		fmt.Println("x == x1")
	}

	if x == y {
		fmt.Println("x == y")
	}
}
