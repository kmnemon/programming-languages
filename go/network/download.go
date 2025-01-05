package network

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
)

const (
	// Define the root directory where files will be served from
	filesDir = "./file" // Adjust this to your desired directory
)

func downloadHandler(w http.ResponseWriter, r *http.Request) {
	fileName := r.URL.Query().Get("filename")
	if fileName == "" {
		http.Error(w, "File name is required", http.StatusBadRequest)
		return
	}

	// Sanitize the file name to prevent directory traversal attacks
	// Remove any ../ patterns
	fileName = filepath.Base(fileName)

	// Build the full file path
	filePath := filepath.Join(filesDir, fileName)

	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		http.Error(w, "File not found", http.StatusNotFound)
		return
	}

	file, err := os.Open(filePath)
	if err != nil {
		http.Error(w, "Error opening file", http.StatusInternalServerError)
		return
	}
	defer file.Close()

	w.Header().Set("Content-Type", "application/octet-stream")
	// Optionally, suggest the filename for download
	w.Header().Set("Content-Disposition", fmt.Sprintf("attachment; filename=%s", fileName))

	_, err = io.Copy(w, file)
	if err != nil {
		http.Error(w, "Error reading file", http.StatusInternalServerError)
	}
}
