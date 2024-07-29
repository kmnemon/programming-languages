package memorysyn

import (
	"sync"
)

// 1.mutex
type Counter struct {
	mu    sync.Mutex
	value int
}

func (c *Counter) Increment() {
	c.mu.Lock()
	defer c.mu.Unlock()
	c.value++
}

// 2. mutual exclusion
var mu sync.Mutex // guards balance
var balance int

func Deposit2(amount int) {
	mu.Lock()
	balance = balance + amount
	mu.Unlock()

}

func Balance2() int {
	mu.Lock()
	defer mu.Unlock()
	return balance

}

// 3. mutual exclusion - RWMutex
var rwMu sync.RWMutex // guards balance
var balance3 int

func Deposit3(amount int) {
	rwMu.Lock()
	balance = balance3 + amount
	rwMu.Unlock()

}

func Balance3() int {
	rwMu.RLock() //readers lock
	defer rwMu.RUnlock()
	return balance

}

//RLock允许读取并行，写入和读取完全互斥，多次读取，一次写入
