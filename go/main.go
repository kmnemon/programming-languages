package main

import (
	"fmt"
	"net/http"

	"github.com/kmnemon/programming/network"
)

func main() {
	http.HandleFunc("/stock-stream", network.LongLivedHandler)
	server := &http.Server{
		Addr: ":8080",
	}

	fmt.Println("Server is listening on port 8080")
	if err := server.ListenAndServe(); err != nil {
		fmt.Println("Server failed:", err)
	}
}
