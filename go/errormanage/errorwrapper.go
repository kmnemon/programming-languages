package errormanage

import (
	"errors"
	"fmt"
)

func bar() error {
	return fmt.Errorf("bar(): error")
}

// 1. Marking an error as a specific error
type BarError struct {
	Err error
}

func (b BarError) Error() string {
	return "bar failed:" + b.Err.Error()
}

func Foo() error {
	err := bar()
	if err != nil {
		return BarError{Err: err}
	}

	return nil
}

// 2. Adding additional context to an error
// %w without having to create another error type, a client can unwarp the parent error
func Foo2() error {
	err := bar()
	if err != nil {
		return fmt.Errorf("Foo2(): bar failed: %w", err)
	}

	return nil
}

// 3. Adding additional context to an error and transform
// %v transform it into another error, and the source error is no longer available
func Foo3() error {
	err := bar()
	if err != nil {
		return fmt.Errorf("Foo3(): bar failed: %v", err)
	}

	return nil
}

// how to check the error
func CheckError() {
	err := Foo2()
	if err != nil {
		fmt.Println(err.Error())
	}
}

//.........................

// 1. check the original and unwrap errors
/*
Purpose: errors.As is used to extract and check if an error in the chain can be cast to a specific type (usually a concrete error type). This allows you to inspect or interact with errors that have a specific type or additional information.
Use Case: errors.As is useful when you need to access or handle an error that is wrapped in a more concrete type (such as a custom error type with additional fields).
*/
type transientError struct {
	id  int
	err error
}

func (t transientError) Error() string {
	return fmt.Sprintf("transient error: %v", t.err)
}

func bar2() error {
	err := fmt.Errorf("the db failed")
	return fmt.Errorf("bar2() failed: %w", transientError{err: err, id: 123})
}

func CheckTheOriginErrorAndUnWrap() {
	err := bar2()
	if err != nil {
		var t transientError
		if errors.As(err, &t) {
			//if it is transientError do something
			fmt.Println(t.id)
		} else {
			//another type of error do something
		}
	}
}

// 2.check the original error
/*
Purpose: errors.Is is used to check if a specific error is equal to a target error, or if an error is wrapped in another error, it checks if the target error appears anywhere in the error chain.
Use Case: Typically, errors.Is is used when you want to check if an error matches a specific sentinel error or is part of an error chain.
*/
var ErrNotFound = errors.New("not found")

func search() error {
	// Simulate an error being wrapped
	return fmt.Errorf("search failed: %w", ErrNotFound)
}

func checkTheOriginalError() {
	err := search()

	if errors.Is(err, ErrNotFound) {
		fmt.Println("Item not found!")
	} else {
		fmt.Println("Other error:", err)
	}
}
