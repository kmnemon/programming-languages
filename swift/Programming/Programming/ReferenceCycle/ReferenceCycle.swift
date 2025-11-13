//
//  ReferenceCycle.swift
//  Programming
//
//  Created by ke on 11/11/25.
//

class Window {
    weak var rootView: View?
    deinit {
        print("Deinit Window")
    }
    
    var onRotate: (() -> ())? = nil
}

class View {
    var window: Window
    init(window: Window) {
        self.window = window
    }
    deinit {
        print("Deinit View")
    }
}

var storedRotate: (() -> ())?

func main() {
    var window: Window? = Window()
    var view: View? = View(window: window!)
    //1. leak
    window?.onRotate = { [view] in
        print("We now also need to update the view: \(String(describing: view))")
    }
    
    //2. break the leak
    window?.onRotate = { [weak sview] in
        print("We now also need to update the view: \(String(describing: view))")
    }
    
    //3. no leak, because the view capture the view's local variable
    window?.onRotate = {
        print("We now also need to update the view: \(String(describing: view))")
    }
    
    storedRotate = window?.onRotate
    view = nil
    window = nil
}


