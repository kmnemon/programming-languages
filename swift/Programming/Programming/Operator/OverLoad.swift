//
//  OverLoad.swift
//  Programming
//
//  Created by ke Liu on 9/4/25.
//

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

// Overload the + operator for Vector2D
func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

// Usage
let vector1 = Vector2D(x: 3.0, y: 1.0)
let vector2 = Vector2D(x: 2.0, y: 4.0)
let result = vector1 + vector2  // Vector2D(x: 5.0, y: 5.0)
