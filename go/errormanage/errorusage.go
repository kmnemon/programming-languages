package errormanage

import (
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
)

// how to create error
type GooError struct {
	err error
}

func (g GooError) Error() string {
	return "Goo failed:" + g.err.Error()
}

func createErrors() error {
	err := errors.New("error")          //by value
	err = fmt.Errorf("error")           //by value
	err = GooError{err: fmt.Errorf("")} //by type

	return err
}

// 0.if there is a specific error, using bool
func oneSpecificError() {
	// value, ok := cache.Lookup(key)
	// if !ok {}

	// }
}

// 1.propagate the error
func propagate() error {
	_, err := http.Get("")
	if err != nil {
		return err
	}
	//...
	return nil
}

//2.add new information
//2a.transform it into another error
//2b.wrap error
//see errorwrapper

// 3.if progress is impossible, the cal ler can print the error and stop the program gracefully
func stopTheProgram() {
	if err := WaitForServer(""); err != nil {
		fmt.Fprintf(os.Stderr, "Site is down: %v\n", err)
		os.Exit(1)
	}

	if err := WaitForServer(""); err != nil {
		log.Fatalf("Site is down: %v\n", err)
	}
}

// 4.in some case, it's sufficient just to log the error and then continue, perhaps with reduced functionality.
func Ping() error {
	return nil
}

func continueRun() {
	if err := Ping(); err != nil {
		log.Printf("ping failed: %v; networking disabled", err)
		//or print directly to the standard error stream
		fmt.Fprintf(os.Stderr, "ping failed: %v; networking disabled\n", err)
	}
	//continue run
}

// 5.in rare case we can safely ignore an error entirely:
func ignoreError() error {
	dir, err := os.MkdirTemp("", "scratch")
	if err != nil {
		return fmt.Errorf("failed to create temp dir: %v", err)
	}
	// ...use temp dir...
	os.RemoveAll(dir) // ignore errors; $TMPDIR is cleaned periodically

	return nil
}
