package network

import (
	"fmt"
	"net/http"
)

/*
1.x-www-form-urlencoded,
2.multipart/form-data
3.text/plain

<form action=http://127.0.0.1:8080/process?hello=world&thread=123
➥ method="post" enctype="application/x-www-form-urlencoded">
HTML forms and Go 77
              <input type="text" name="hello" value="sau sheong"/>
              <input type="text" name="post" value="456"/>
              <input type="submit"/>
            </form>
*/

func headers(w http.ResponseWriter, r *http.Request) {
	h := r.Header
	fmt.Fprintln(w, h)
}

func body(w http.ResponseWriter, r *http.Request) {
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	fmt.Fprintln(w, string(body))
}

func processParseForm(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	fmt.Fprintln(w, r.Form)
	//map[thread:[123] hello:[sau sheong world] post:[456]]

	fmt.Fprintln(w, r.Form["post"])
	//map[post:[456] hello:[sau sheong]]

	fmt.Fprintln(w, r.FormValue("hello"))
	//sau sheong

	fmt.Fprintln(w, r.PostFormValue("hello"))
	//sau sheong

	fmt.Fprintln(w, r.PostForm)
	//map[hello:[sau sheong] post:[456]]
}

func processParseMultipartForm(w http.ResponseWriter, r *http.Request) {
	r.ParseMultipartForm(1024)
	fmt.Fprintln(w, r.MultipartForm)
	//&{map[hello:[sau sheong] post:[456]] map[]}
}

func webservers() {
	server := http.Server{
		Addr: "127.0.0.1:8080",
	}
	http.HandleFunc("/process", processParseForm)
	server.ListenAndServe()
}
