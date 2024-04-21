package concurrency

import (
	"image"
	"sync"
)

//1.channel - monitor goroutine

var deposits = make(chan int) // send amount to deposit
var balances = make(chan int) // receive balance

func Deposit(amount int) { deposits <- amount }
func Balance() int       { return <-balances }
func teller() {
	var balance int // balance is confined to teller goroutine

	for {
		select {
		case amount := <-deposits:
			balance += amount
		case balances <- balance:
		}
	}
}

func init() {
	go teller() // start the monitor goroutine
}

//2.channel - serial confinement

type Cake struct{ state string }

func baker(cooked chan<- *Cake) {
	for {
		cake := new(Cake)
		cake.state = "cooked"
		cooked <- cake // baker never touches this cake again
	}

}

func icer(iced chan<- *Cake, cooked <-chan *Cake) {
	for cake := range cooked {
		cake.state = "iced"
		iced <- cake // icer never touches this cake again
	}

}

//3.mutual exclusion

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

//4.mutual exclusion - RWMutex

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

//5.Lazy Initialization - sync.Once

var loadIconsOnce sync.Once
var icons map[string]image.Image

func loadIcons()

// Concurrency-safe.
func Icon(name string) image.Image {
	loadIconsOnce.Do(loadIcons)
	return icons[name]
}
