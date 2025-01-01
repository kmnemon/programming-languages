package concurrency

import "testing"

func TestConcurrentExample(t *testing.T) {
	r := concurrentExample()
	if r != 10 {
		t.Errorf("concurent fail")
	}
}

func TestParallelExample(t *testing.T) {
	r := parallelExample()
	if r != 35 {
		t.Errorf("concurent fail")
	}
}

func TestConcurrentWithParallelExample(t *testing.T) {
	r := concurrentWithParallelExample()
	if r != 70 {
		t.Errorf("concurent fail")
	}
}
