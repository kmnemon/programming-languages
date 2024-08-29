//
//  ARC.swift
//  Programming
//
//  Created by ke on 2024/8/29.
//

import Foundation

struct ARC{}

//1. Weak
/*
 weak reference is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance. Because weak references are allowed to have “no value”, you must declare every weak reference as having an optional type.
 
 Person====Strong===>Apartment
 Person<===Weak====Apartment
*/
 
extension ARC{
    class Person {
        let name: String
        init(name: String) { self.name = name }
        var apartment: Apartment?
        deinit { print("\(name) is being deinitialized") }
    }
    
    
    class Apartment {
        let unit: String
        init(unit: String) { self.unit = unit }
        weak var tenant: Person?
        deinit { print("Apartment \(unit) is being deinitialized") }
    }
    
    static func weakRun() {
        var john: Person?
        var unit4A: Apartment?


        john = Person(name: "John Appleseed")
        unit4A = Apartment(unit: "4A")


        john!.apartment = unit4A
        unit4A!.tenant = john
        
        john = nil
        // Prints "John Appleseed is being deinitialized"
        
        unit4A = nil
        // Prints "Apartment 4A is being deinitialized"
    }
}


//2. Unowned
/*
 Like weak references, an unowned reference does not keep a strong hold on the instance it refers to. Unlike a weak reference, however, an unowned reference is assumed to always have a value. Because of this, an unowned reference is always defined as a non-optional type.
 
 Customer====Strong====>CreditCard
 Customer<===Unowned====CreditCard
 */
extension ARC{
    class Customer {
        let name: String
        var card: CreditCard?
        init(name: String) {
            self.name = name
        }
        deinit { print("\(name) is being deinitialized") }
    }
    
    
    class CreditCard {
        let number: UInt64
        unowned let customer: Customer
        init(number: UInt64, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        deinit { print("Card #\(number) is being deinitialized") }
    }
    
    func unownedRun() {
        var john: Customer?
        john = Customer(name: "john")
        john!.card = CreditCard(number: 123, customer: john!)
        
        john = nil
        // Prints "John Appleseed is being deinitialized"
        // Prints "Card #1234567890123456 is being deinitialized"
    }
}
