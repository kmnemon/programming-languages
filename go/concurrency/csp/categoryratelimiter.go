package csp

import (
	"context"
	"time"

	"golang.org/x/time/rate"
)

func Open3() *APIConnection3 {
	return &APIConnection3{
		apiLimit: MultiLimiter(
			rate.NewLimiter(Per(2, time.Second), 2),
			rate.NewLimiter(Per(10, time.Minute), 10),
		),
		diskLimit: MultiLimiter(
			rate.NewLimiter(rate.Limit(1), 1),
		),
		networkLimit: MultiLimiter(
			rate.NewLimiter(Per(3, time.Second), 3),
		)}
}

type APIConnection3 struct {
	networkLimit,
	diskLimit,
	apiLimit RateLimiter
}

func (a *APIConnection3) ReadFile(ctx context.Context) error {
	err := MultiLimiter(a.apiLimit, a.diskLimit).Wait(ctx)
	if err != nil {
		return err
	}
	// Pretend we do work here
	return nil
}

func (a *APIConnection3) ResolveAddress(ctx context.Context) error {
	err := MultiLimiter(a.apiLimit, a.networkLimit).Wait(ctx)
	if err != nil {
		return err
	}
	// Pretend we do work here
	return nil
}
