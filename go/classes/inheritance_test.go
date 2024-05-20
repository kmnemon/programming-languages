package classes

import (
	"fmt"
	"testing"
)

func TestCopyValue(t *testing.T) {

	var a [3]int = [3]int{1, 2, 3}
	fmt.Println(a)

	b := a
	a[0] = 9

	fmt.Println(b)

	c := make(map[int]string, 0)
	c[3] = "df"
	fmt.Println(c)

	d := c
	c[3] = "haha"
	fmt.Println(d)
}
