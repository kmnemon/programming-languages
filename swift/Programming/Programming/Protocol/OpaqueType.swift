//
//  OpaqueType.swift
//  Programming
//
//  Created by ke Liu on 12/12/25.
//

protocol RichText {
    func render() -> String
}

extension String: RichText {
    func render() -> String {
        self
    }
}

struct Bold<Text: RichText>: RichText {
    var text: Text
    func render() -> String {
        "**\(text.render())**"
    }
}

struct Italic<Text: RichText>: RichText {
    var text: Text
    func render() -> String {
        "_\(text.render())_"
    }
}

//Bold(text: "bold").render() // **bold**
//Bold(text: Italic(text: "bold and italic")).render() // **_bold and italic_**



struct Concat<Text1: RichText, Text2: RichText>: RichText {
    var a: Text1
    var b: Text2
    func render() -> String {
        "\(a.render())\(b.render())"
    }
}

extension RichText {
    func bold1() -> Bold<Self> {
        Bold(text: self)
    }
    func italic1() -> Italic<Self> {
        Italic(text: self)
    }
    func appending1<Other: RichText>(_ other: Other) -> Concat<Self, Other> {
        Concat(a: self, b: other)
    }
}



func typeExplode() {
    let text = "Hello,"
        .bold1()
        .appending1(" ")
        .appending1(
            "world!".italic()
        )
    print(text.render()) // **Hello,** _world!_”
    print(type(of: text)) //Concat<Concat<Bold<String>, String>, Italic<String>>
}

extension RichText {
    func bold() -> some RichText {
        Bold(text: self)
    }
    func italic() -> some RichText {
        Italic(text: self)
    }
    func appending<Other: RichText>(_ other: Other) -> some RichText {
        Concat(a: self, b: other)
    }
}

func typeHidden() {
    let text = "Hello,"
        .bold()
        .appending(" ")
        .appending(
            "world!".italic()
        )
    print(text.render()) // **Hello,** _world!_”
    print(type(of: text)) //RichText
}
