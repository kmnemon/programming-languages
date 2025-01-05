package network

import "net/http"

func HandleFunction() {
	http.HandleFunc("/longlivestream", longLiveStreamHandler)
	http.HandleFunc("/file/download", downloadHandler)

}
