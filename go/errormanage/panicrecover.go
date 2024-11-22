package errormanage

import (
	"fmt"
	"os"
	"runtime"
)

func f(x int) {
	fmt.Printf("f(%d)\n", x+0/x) // panics if x == 0
	defer fmt.Printf("defer %d\n", x)
	f(x - 1)
}

func printStack() {
	var buf [4096]byte
	n := runtime.Stack(buf[:], false)
	os.Stdout.Write([]byte("what is it"))
	os.Stdout.Write(buf[:n])
}

// 1. Panic
func callThePanic() {
	defer printStack()

	f(3)
}

// 2. Recover from panic
func callThePanicAndRecover() {
	defer func() {
		if p := recover(); p != nil {
			fmt.Printf("internal error: %v", p)
		}
	}()

	f(3)
}

// 3. Recover from panic with specific value
type baiout struct{}

func panicWithValue() {
	panic(baiout{})
}

func callThePanicAndRecoverWithSpecificValue() {
	defer func() {
		switch p := recover(); p {
		case nil:
			//no panic
		case baiout{}:
			//"expected" panic
		default:
			panic(p) //unexpected panic; carry on panicking
		}
	}()

	panicWithValue()
}
