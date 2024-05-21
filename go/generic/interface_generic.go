package generic

type Container[T any] interface {
	append(item T)
	count() int
}
