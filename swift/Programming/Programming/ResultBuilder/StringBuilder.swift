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
    
    //3 provide clearer compiler diagnostics
    @available(*, unavailable,
                message: "String Builders only support string and integer values")
    static func buildExpression<A>(_ expression: A) -> String {
        ""
    }
    
    //4 support condition if
    static func buildIf(_ s: String?) -> String {
        s ?? ""
    }
    
    //5 support condition if else
    static func buildEither(first component: String) -> String {
        component
    }
    static func buildEither(second component: String) -> String {
        component
    }
    
    //6 support for...in loop
    static func buildArray(_ components: [String]) -> String {
        components.joined(separator: "")
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

//4
@StringBuilder func greet(planet: String) -> String {
    "Hello, Planet"
    if let idx = planets.firstIndex(of: planet) {
        " "
        idx
    }
    "!"
}
//greet(planet: "Earth") // Hello, Planet 2!
//greet(planet: "Sun") // Hello, Planet!”

func greet_rewritten(planet: String) -> String {
    let v0 = "Hello, Planet"
    var v1: String?
    if let idx = planets.firstIndex(of: planet) {
        v1 = StringBuilder.buildBlock(
            StringBuilder.buildExpression(" "),
            StringBuilder.buildExpression(idx)
        )
    }
    let v2 = StringBuilder.buildIf(v1)
    return StringBuilder.buildBlock(v0, v2)
}

//5
@StringBuilder func greet2(planet: String) -> String {
    "Hello, "
    if let idx = planets.firstIndex(of: planet) {
        switch idx {
            case 2:
                "World"
            case 1, 3:
                "Neighbor"
            default:
                "planet "
                idx + 1
        }
    } else {
        "unknown planet"
    }
    "!"
}
//greet2(planet: "Earth") // Hello, World!
//greet2(planet: "Mars") // Hello, Neighbor!
//greet2(planet: "Jupiter") // Hello, planet 5!
//greet2(planet: "Pluto") // Hello, unknown planet!”

func greet2_rewritten(planet: String) -> String {
    let v0 = StringBuilder.buildExpression("Hello, ")
    let v1: String
    if let idx = planets.firstIndex(of: planet) {
        let v1_0: String
        switch idx {
            case 2:
                v1_0 = StringBuilder.buildEither(first: StringBuilder.buildBlock(StringBuilder.buildExpression("World")))
            case 1, 3:
                v1_0 = StringBuilder.buildEither(second: StringBuilder.buildEither(first: StringBuilder.buildBlock(StringBuilder.buildExpression("Neighbor"))))
            default:
                let v1_0_0 = StringBuilder.buildExpression("planet")
                let v1_0_1 = StringBuilder.buildExpression(idx + 1)
                
                v1_0 = StringBuilder.buildEither(second: StringBuilder.buildEither(second: StringBuilder.buildBlock(v1_0_0, v1_0_1)))
        }
        v1 = StringBuilder.buildEither(first: v1_0)
    } else {
        v1 = StringBuilder.buildEither(second: StringBuilder.buildBlock( StringBuilder.buildExpression("unknown planet")))
    }
    let v2 = StringBuilder.buildExpression("!")
    return StringBuilder.buildBlock(v0, v1, v2)
}

//6
@StringBuilder func greet3(planet: String?) -> String {
    "Hello "
    if let p = planet {
        p
    } else {
        for p in planets.dropLast() {
            "\(p), "
        }
        "and \(planets.last!)!"
    }
}
//greet3(planet: nil)
// Hello Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, and Neptune!”

func greet3_rewritten(planet: String?) -> String {
    let v0 = StringBuilder.buildExpression("Hello ")
    let v1: String
    if let p = planet {
        v1 = StringBuilder.buildBlock(StringBuilder.buildExpression(p))
    } else {
        var v1_0: [String] = []
        for p in planets.dropLast() {
            let v1_0_0 = StringBuilder.buildBlock(
                StringBuilder.buildExpression("\(p), ")
            )
            v1_0.append(v1_0_0)
        }
        let v1_1 = StringBuilder.buildArray(v1_0)
        let v1_2 = "and \(planets.last!)!"
        v1 = StringBuilder.buildBlock(v1_1, v1_2)
    }
    return StringBuilder.buildBlock(v0, v1)
}
