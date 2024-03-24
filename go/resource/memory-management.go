package resource

import "fmt"

//1.using GC
type Automate struct {

}

func usingGC(){
	a := Automate{}
	fmt.Println(a)
}