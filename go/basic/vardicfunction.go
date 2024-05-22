package basic

func sum(numbers ...int) int {
	total := 0
	for _, number := range numbers {
		total += number
	}
	return total
}

func testSum() {
	sum(1, 2, 3, 4, 6)
}
