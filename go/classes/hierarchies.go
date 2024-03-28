package classes

import "fmt"

// composing type
type Point struct {
	X, Y int
}

func (p Point) DistanceOfX(pb Point) int {
	return pb.X - p.X
}

type Color struct {
	Color int
}

func (c Color) Colors(p Point) string {
	return ""
}

type ColoredPoint struct {
	Point
	*Color
	Radius int
}

func StructEmbedding() {
	cp := ColoredPoint{Point{2, 5}, &Color{6}, 4}
	cp.DistanceOfX(Point{1, 2})
	cp.Colors(cp.Point)

	p := Point{2, 5}
	// p.DistanceOfX(q) cannot use q(ColoredPoint) as Point
	fmt.Println(p.X)
}
