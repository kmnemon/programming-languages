package pattern

import (
	"errors"
	"fmt"
	"net/http"
)

// option pattern
type options struct {
	port *int
}

type Option func(options *options) error

func WithPort(port int) Option {
	return func(options *options) error {
		if port < 0 {
			return errors.New("port should be positive")
		}
		options.port = &port
		return nil
	}
}

// usage
const defaultHTTPPort = 8080

func randomPort() int {
	return 10
}

func NewServer(addr string, opts ...Option) (*http.Server, error) {
	var options options
	for _, opt := range opts {
		err := opt(&options)
		if err != nil {
			return nil, err
		}
	}

	var port int
	if options.port == nil {
		port = defaultHTTPPort
	} else {
		if *options.port == 0 {
			port = randomPort()
		} else {
			port = *options.port
		}
	}

	//...
	fmt.Println(port)
	return nil, nil
}

func InitServer() {
	NewServer("localhost",
		WithPort(8080),
		//...
	)

	//with default config
	NewServer("localhost")
}
