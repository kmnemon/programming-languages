package generic

import "fmt"

// 1.generic function
func inspect[T any](value T) {
	fmt.Println(value)
}

// 2.constraint type
type Int interface {
	~int | ~int8 | ~int16 | ~int32 | ~int64
}

type Uint interface {
	~uint | ~uint8 | ~uint16 | ~uint32
}

type Float interface {
	~float32 | ~float64
}

type IntegerType interface {
	Int | Uint | Float
}

func squareSomething[T IntegerType](value T) T {
	return value * value
}
