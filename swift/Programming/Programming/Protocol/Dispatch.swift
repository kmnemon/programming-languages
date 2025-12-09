//
//  Dispatch.swift
//  Programming
//
//  Created by ke Liu on 12/9/25.
//

protocol Dispatch {
    func dynamicDispatch()
}

extension Dispatch {
    func dynamicDispatch() {
        print("dynamic dispatch")
    }
    
    func staticDispatch() {
        print("static dispatch")
    }
    
    func dispatch() {
        dynamicDispatch()
        staticDispatch()
    }
}

struct DispatchStruct: Dispatch {
    func dynamicDispatch() {
        print("override dynamic dispatch")
    }
    
    func staticDispatch() {
        print("override static dispatch")
    }
    
}

func dispatchExample() {
    let d = DispatchStruct()
    d.dispatch() //"override dynamic dispatch, static dispatch"
}
