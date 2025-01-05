package network

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

type Stock struct {
	Name  string  `json:"name"`
	Value float64 `json:"value"`
}

func longLiveStreamHandler(w http.ResponseWriter, r *http.Request) {
	// Set headers to keep the connection open
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Cache-Control", "no-cache")
	w.Header().Set("Connection", "keep-alive")

	// Create a new stock instance
	stock := Stock{
		Name:  "Apple Inc.",
		Value: 175.23,
	}

	// Continuously send data
	for {
		select {
		case <-r.Context().Done():
			// If the client closes the connection, break the loop
			return
		default:
			// Encode stock data to JSON
			if err := json.NewEncoder(w).Encode(stock); err != nil {
				fmt.Println("Error while encoding JSON:", err)
				return
			}

			// Flush the data to ensure it's sent immediately
			if flusher, ok := w.(http.Flusher); ok {
				flusher.Flush()
			} else {
				fmt.Println("Streaming not supported")
			}

			// Update stock value (for demo purposes, change the value)
			stock.Value += 0.1

			// Sleep before sending the next update
			time.Sleep(2 * time.Second)
		}
	}
}
