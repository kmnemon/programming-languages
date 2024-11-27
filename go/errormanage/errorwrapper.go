package errormanage

import "fmt"

func bar() error {
	return nil
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
		return fmt.Errorf("bar failed: %w", err)
	}

	return nil
}

// 3. Adding additional context to an error and transform
// %v transform it into another error, and the source error is no longer available
func Foo3() error {
	err := bar()
	if err != nil {
		return fmt.Errorf("bar failed: %v", err)
	}

	return nil
}
