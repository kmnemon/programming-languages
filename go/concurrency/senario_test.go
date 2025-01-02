package concurrency

import "testing"

func TestParallelExample(t *testing.T) {
	r := parallelExample()
	if r != 10 {
		t.Errorf("concurent fail")
	}
}

func TestConcurrentExample(t *testing.T) {
	r := concurrentExample()
	if r != 35 {
		t.Errorf("concurent fail")
	}
}

func TestParallelWithConcurrentExample(t *testing.T) {
	r := parallelWithConcurrentExample()
	if r != 70 {
		t.Errorf("concurent fail")
	}
}
