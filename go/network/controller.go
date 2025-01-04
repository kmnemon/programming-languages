package network

import "net/http"

func HandleFunction() {
	http.HandleFunc("/longlivestream", LongLiveStreamHandler)

}
