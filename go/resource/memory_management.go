package resource

import "fmt"

// 1.using GC
type Automate struct {
}

func usingGC() {
	a := Automate{}
	fmt.Println(a)
}

//2.reference cycles problem,In this specific case,
/*when you set both ca and cb to nil,
you're effectively breaking the cyclic reference between A and B.
Since there are no other references to the memory allocated for A and B,
the garbage collector will eventually detect that these objects
are unreachable and free their memory.*/
type A struct {
	b *B
}

type B struct {
	a *A
}

func rc() {
	ca := &A{}
	cb := &B{}

	ca.b = cb
	cb.a = ca

	ca = nil
	cb = nil
}
