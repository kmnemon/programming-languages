//
//  ImplicitUnwrappedOptional.swift
//  Programming
//
//  Created by ke Liu on 10/26/25.
//

func implicitUnwrappedOptional() {
    var a: String! = "H"
    let b = a + "o"
    print(b) // "Ho"
    
    a?.isEmpty //Optional(false)
    if let a = a { print(a) } //H
    a = nil
    a ?? "Goodbye" //Goodbye
    
}
