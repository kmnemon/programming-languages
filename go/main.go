package main

import (
	"fmt"
	"net/http"

	"github.com/kmnemon/programming/network"
)

func main() {
	network.HandleFunction()

	server := &http.Server{
		Addr: ":9091",
	}

	fmt.Println("Server is listening on port 9091")
	if err := server.ListenAndServe(); err != nil {
		fmt.Println("Server failed:", err)
	}
}
