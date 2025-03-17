package errormanage

import (
	"context"

	"golang.org/x/sync/errgroup"
)

type Result struct {
	// some fields
}

func errorgroup(ctx context.Context, circles []int) ([]Result, error) {
	results := make([]Result, len(circles))
	g, ctx := errgroup.WithContext(ctx)

	for i, circle := range circles {
		i, circle := i, circle
		g.Go(func() error {
			// do something with circle
			result, err := foo(ctx, circle)
			if err != nil {
				return err
			}
			results[i] = result
			return nil
		})
	}

	if err := g.Wait(); err != nil {
		return nil, err
	}

	return results, nil
}

func foo(ctx context.Context, circle int) (Result, error) {
	// do something with circle
	return Result{}, nil
}
