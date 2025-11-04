//
//  StringBuilder.swift
//  Programming
//
//  Created by ke on 11/4/25.
//

@resultBuilder
struct StringBuilder {
    //1 only buildBlock
    static func buildBlock(_ strings: String...) -> String {
        strings.joined()
    }
   
    //2 buildBlock + buildExpression
    static func buildExpression(_ s: String) -> String {
        s
    }
    static func buildExpression(_ x: Int) -> String {
        "\(x)"
    }
}

//1
@StringBuilder func greeting() -> String {
    "Hello,"
    "World!"
}


// the compiler rewrite to buildBlock when there is no buildExpression
func greeting_rewritten() -> String {
    StringBuilder.buildBlock(
        "Hello,",
        "World!"
    )
}

//2
let planets = [
    "Mercury", "Venus", "Earth", "Mars", "Jupiter",
    "Saturn", "Uranus", "Neptune"
]

@StringBuilder func greetEarth() -> String {
    "Hello, Planet"
    planets.firstIndex(of: "Earth")!
    "!"
}

//greetEarth() //Hello, Planet 2!

// the comipler rewrite to buildBlock + buildExpress when there have buildExpress implement
func greetEarth_rewritten() -> String {
    StringBuilder.buildBlock(
        StringBuilder.buildExpression("Hello, Planet"),
        StringBuilder.buildExpression(planets.firstIndex(of: "Earth")!),
        StringBuilder.buildExpression("!")
    )
}

