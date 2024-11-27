package errormanage

import "fmt"

//Adding additional context to an error
//Marking an error as a specific error

func bar() error {
	return nil
}

// before Go 1.13
// we want to wrap BarError add addtion information
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

// now
// %w without having to create another error type, a client can unwarp the parent error
func Foo2() error {
	err := bar()
	if err != nil {
		return fmt.Errorf("bar failed: %w", err)
	}

	return nil
}

// %v transform it into another error, and the source error is no longer available
func Foo3() error {
	err := bar()
	if err != nil {
		return fmt.Errorf("bar failed: %v", err)
	}

	return nil
}
