package functional

//Functional programming - Programming without assignment statements(without variables).
//functional programs are composed of true mathematical, referentially transparent functions

// non-functional
var n int = 1
var sum int = 0

func done() bool {
	return n > 10
}

func doSomething() {
	sum += n * n
	n++
}

func sumFirstTenSquaresNonFunctional() {
	for !done() {
		doSomething()
	}
}

// functional
func sumFirstTenSquaresHelper(sum int, i int) int {
	if i > 10 {
		return sum
	}
	return sumFirstTenSquaresHelper(sum+i*i, i+1)
}

func sumFirstTenSquares() int {
	return sumFirstTenSquaresHelper(0, 1)
}

// non-functional, tail call optimization (TCO),
// compiler ture that last program into the milestoneprogram
func sumFirstTenSquaresHelperTCO(sum int, i int) int {
loop:
	if i > 10 {
		return sum
	}
	sum += i * i
	i++
	goto loop
}
