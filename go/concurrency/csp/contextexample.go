package csp

import (
	"context"
	"fmt"
	"time"
)

//1.deadline
/*
A deadline refers to a specific point in time determined with one of the following:
1.A time.Duration from now (for example, in 250 ms)
2.A time.Time (for example, 2023-02-07 00:00:00 UTC)
*/

type Position struct {
	x int
	y int
}

type publisher interface {
	Publish(ctx context.Context, position Position) error
}

type publishHandler struct {
	pub publisher
}

/*
Internally, context.WithTimeout creates a goroutine that will be retained in memory for 4 seconds or until cancel is called.
Therefore, calling cancel as a defer function means that when we exit the parent function, the context will be canceled,
and the goroutine created will be stopped. It’s a safeguard so that when we return, we don’t leave retained objects in memory.
*/
func (h publishHandler) publishPosition(position Position) error {
	ctx, cancel := context.WithTimeout(context.Background(), 4*time.Second)
	defer cancel()
	return h.pub.Publish(ctx, position)
}

type publishImplement struct {
}

func (pi publishImplement) Publish(ctx context.Context, position Position) error {
	select {
	case <-ctx.Done():
		// If the context times out or is canceled, handle it here.
		return ctx.Err()
	default:
		// Simulating some publishing logic.
		fmt.Printf("Published Position: (%d, %d)\n", position.x, position.y)
		return nil
	}
}
