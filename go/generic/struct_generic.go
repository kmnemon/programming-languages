package generic

// 1.generic type
type deque[T any] struct {
	array []T
}

func (d *deque[T]) pushBack(obj T) {
	d.array = append(d.array, obj)
}
