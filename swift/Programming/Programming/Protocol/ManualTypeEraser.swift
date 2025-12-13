//
//  TypeEraser.swift
//  Programming
//
//  Created by ke Liu on 12/13/25.
//

/*
 manual type eraser
 if let restorables: [any Restorable] do not support by swift
 */


// a type eraser for Restorable protocol
protocol Restorable {
    associatedtype State: Codable
    var state: State { get set }
}

// three class to implement type eraser

/* 1.This class represents:
 “Some unknown Restorable whose State is State.”
 */
class AnyRestorableBoxBase<State: Codable>: Restorable {
    internal init() { }
    public var state: State {
        get { fatalError() }
        set { fatalError() }
    }
}

/* 2. This is the actual worker of the type erasure.
 Purpose:
 * Wraps a concrete Restorable
 * Bridges calls from erased interface → real implementation
 */
class AnyRestorableBox<R: Restorable>: AnyRestorableBoxBase<R.State> {
    var r: R
    init(_ r: R) {
        self.r = r
    }
    override var state: R.State {
        get { r.state }
        set { r.state = newValue }
    }
}

/* 3.
 Purpose
 * Public-facing erased type
 * Safe, value-type API
 * Hides class-based machinery
 */
struct AnyRestorable<State: Codable>: Restorable {
    private let box: AnyRestorableBoxBase<State>
    init<R>(_ r: R) where R: Restorable, R.State == State {
        self.box = AnyRestorableBox(r)
    }
    var state: State {
        get { box.state }
        set { box.state = newValue }
    }
}

//Usage:
struct UserSession: Restorable {
    var state: String
}

struct CacheEntry: Restorable {
    var state: Int
}

func manualWithTypeErasure() {
    let session = AnyRestorable(UserSession(state: "logged-in"))
    let cache = AnyRestorable(CacheEntry(state: 42))
    
    let stringRestorables: [AnyRestorable<String>] = [session]
    let intRestorables: [AnyRestorable<Int>] = [cache]
}

// if existential are not limit
func doNotNeedManualTypeErasure() {
    let session = UserSession(state: "logged-in")
    let cache = CacheEntry(state: 42)
    
    let restorables: [any Restorable] = [session, cache]
}
