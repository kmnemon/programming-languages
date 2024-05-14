package closure

import "fmt"

func closureExample() {
	greet := func(name string) string {
		return "Hello, " + name + "!"
	}

	// Call the function and assign its return value to a variable
	greeting := greet("John")

	// Print the greeting
	fmt.Println(greeting)
}
