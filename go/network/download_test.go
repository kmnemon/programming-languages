package network

import (
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestDownloadHandler(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "http://localhost", strings.NewReader("foo"))
	w := httptest.NewRecorder()
	downloadHandler(w, req)

	if got := w.Result().Header.Get("Content-Type"); got != "application/octet-stream" {
		t.Errorf("api version: expected application/octet-stream, got %s", got)

		body, _ := io.ReadAll(w.Body)
		if got := string(body); got != "hello foo" {
			t.Errorf("body: expected hello foo, got %s", got)
		}
	}

	if http.StatusOK != w.Result().StatusCode {
		t.FailNow()
	}
}
