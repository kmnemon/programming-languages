//
//  MemoryManagement.swift
//  swift
//
//  Created by ke on 3/24/24.
//

import Foundation
struct MemoryManagement{}

extension MemoryManagement {
    //1.using ARC
    class ARC {
        
    }
    
    func usingARC() {
        var ref1: ARC? = ARC()
        var ref2: ARC? = ref1
        
        ref1 = nil
        ref2 = nil
    }
    
    //2.reference cycles problem
    class A {
        var b: B?
    }
    
    class B {
        var a: A?
    }
    
    func rc() {
        var ca: A? = A()
        var cb: B? = B()
        ca!.b = cb
        cb!.a = ca
        
        ca = nil
        cb = nil
    }
    
    //3.weak reference
    //Apartment has longer life than Person(tenant)
    class Person {
        var apartment: Apartment?
        deinit { print("Person deinit") }
    }
    
    class Apartment {
        weak var tenant: Person?
        deinit { print("Apartment deinit") }
    }
    
    func weakReference() {
        var tom: Person? = Person()
        var apartment: Apartment? = Apartment()
        
        tom?.apartment = apartment
        apartment?.tenant = tom
        
        tom = nil
        //Person deinit
        
        apartment = nil
        //Apartment deinit
    }
    
    //4.unowned reference
    //Customer has longer lift than CreditCard
    class Customer {
        var card: CreditCard?
        deinit { print("Customer deinit") }
    }
    
    class CreditCard {
        unowned let customer: Customer
        init(customer: Customer) { self.customer = customer }
        deinit { print("CreditCard deinit") }
    }
    
    func unownedReference() {
        var tom: Customer? = Customer()
        tom!.card = CreditCard(customer: tom!)
        
        tom = nil
        //Customer deinit
        //CreditCard deinit
    }
    
    
    
}
