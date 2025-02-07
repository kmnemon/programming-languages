package csp

import (
	"context"
	"fmt"
	"time"
)

// 1.context with timeout
func context1() {
	ctx, cancel := context.WithTimeout(context.Background(), 1*time.Second)
	defer cancel()

	go handle(ctx, 500*time.Millisecond)
	select {
	case <-ctx.Done():
		fmt.Println("main", ctx.Err())
	}
}

func handle(ctx context.Context, duration time.Duration) {
	select {
	case <-ctx.Done():
		fmt.Println("handle", ctx.Err())
	case <-time.After(duration):
		fmt.Println("process request with", duration)
	}
}

// 2.context WithValue
const (
	KEY = "trace_id01"
)

func NewRequestID() string {
	return "the game is prefect"
}

func NewContextWithTraceID() context.Context {
	ctx := context.WithValue(context.Background(), KEY, NewRequestID())
	return ctx
}

func GetContextValue(ctx context.Context, k string) string {
	v, ok := ctx.Value(k).(string)
	if !ok {
		return ""
	}
	return v
}

func ProcessEnter(ctx context.Context) {
	fmt.Println(GetContextValue(ctx, KEY))
}

// 3. context timeout
func NewContextWithTimeout() (context.Context, context.CancelFunc) {
	return context.WithTimeout(context.Background(), 3*time.Second)
}
func HttpHandler() {
	ctx, cancel := NewContextWithTimeout()
	defer cancel()
	deal(ctx)
}

func deal(ctx context.Context) {
	for i := 0; i < 10; i++ {
		time.Sleep(1 * time.Second)
		select {
		case <-ctx.Done():
			fmt.Println(ctx.Err())
			return
		default:
			fmt.Printf("deal time is %d\n", i)
		}
	}
}

// 4.withcancel
func Process() {
	ctx, cancel := context.WithCancel(context.Background())
	go Speak(ctx)
	time.Sleep(10 * time.Second)
	cancel()
	time.Sleep(1 * time.Second)
}

func Speak(ctx context.Context) {
	for range time.Tick(time.Second) {
		select {
		case <-ctx.Done():
			fmt.Println("cancel")
			return
		default:
			fmt.Println("processing...")
		}
	}
}

//5. context.Background. context.TODO()
/*
1. context.Background()
Purpose: It is the default context for the root of a context tree. It is typically used in main functions, initialization, or when you're creating the top-level context for your application.
Use case: It is often used when you don't have any other context available, and you're initializing the context for the first time. It’s the context that forms the base or starting point for other contexts.

2. context.TODO()
Purpose: It is used when you're unsure which context to use or you are in the process of implementing your code and haven't figured out the right context yet.
Use case: TODO() is generally a placeholder. You would use it when you're in the middle of writing code and haven't decided on the correct context to use, or when it's not clear what the parent context should be.
*/
