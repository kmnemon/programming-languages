package resource

import "fmt"

//1.automate
type Automate struct {

}

func usingGC(){
	a := Automate{}
	fmt.Println(a)
}