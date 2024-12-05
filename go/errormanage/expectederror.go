package errormanage

import (
	"bufio"
	"fmt"
	"io"
	"os"
)

/*
0.Unexpected error is seldom to recover,we need to use panic
1.Expected errors should be designed as error types: type BarError struct
{ … }, with BarError implementing the error interface.
2.Intentional errors should be designed as error values (sentinel errors): var
ErrFoo = errors.New("foo").
*/

// 1.Expected errors
type NetworkError struct {
	err error
}

func (e NetworkError) Error() string {
	return fmt.Sprintf("network error: %v", e.err)
}

func expectedErrors() error {
	return NetworkError{err: fmt.Errorf("xxx")}
}

// 2.Intentional errors
func IntentionalErrors() error {
	// ErrNotFound := errors.New("not found the string")
	in := bufio.NewReader(os.Stdin)
	for {
		_, _, err := in.ReadRune()
		if err == io.EOF { //var EOF = errors.New("EOF")
			break // finished reading - io.EOF error is intentionalError for no more input is available
		}
		if err != nil {
			return fmt.Errorf("read failed: %v", err)
		}
		// ...use r...
	}

	return nil
}
