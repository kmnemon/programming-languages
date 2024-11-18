//
//  Opaque.swift
//  Programming
//
//  Created by ke on 11/18/24.
//

protocol Fighter: Equatable {}
struct XWing: Fighter {}
struct YWing: Fighter {}

func lanchXFighter() -> some Fighter {
    return XWing()
}

func lanchYFighter() -> some Fighter {
    return YWing()
}


func compareFighter(){
    let x = lanchXFighter()
    let x2 = lanchXFighter()
    let y = lanchYFighter()
    
    if x == x2 {
        print("x == y")
    }
    
    //do not compile
//    if x == y {
//
//    }
}
