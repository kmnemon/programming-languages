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

// check the original errors
type transientError struct {
	err error
}

func (t transientError) Error() string {
	return fmt.Sprintf("transient error: %v", t.err)
}

func bar2() error {
	err := fmt.Errorf("the db failed")
	return fmt.Errorf("bar2() failed: %w", transientError{err: err})
}

func CheckTheOriginError() {
	err := bar2()
	if err != nil {
		if errors.As(err, &transientError{}) {
			//if it is transientError do something
		} else {
			//another type of error do something
		}
	}
}
