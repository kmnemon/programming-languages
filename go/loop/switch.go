package loop

import "fmt"

func switch1() {
	var dayOfWeek = 3

	switch dayOfWeek {
	case 1:
		fmt.Println("Monday")
	case 2:
		fmt.Println("Tuesday")
	case 3:
		fmt.Println("Wednesday")
	case 4:
		fmt.Println("Thursday")
	case 5:
		fmt.Println("Friday")
	default:
		fmt.Println("Weekend")
	}
}

func switch2(x any) {
	switch x := x.(type) {
	case nil:
		fmt.Println("NULL")
	case int, uint:
		fmt.Sprintf("%d", x)
	case bool:
		if x {
			fmt.Println("TRUE")
		}
		fmt.Println("FALSE")
	case string:
		fmt.Println(x)
	default:
		panic(fmt.Sprintf("unexpected type %T: %v", x, x))
	}
}
