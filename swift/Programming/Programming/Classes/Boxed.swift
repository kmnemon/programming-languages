//
//  Boxed.swift
//  Programming
//
//  Created by ke on 2024/12/24.
//




protocol Drawable {
    func draw()
}

struct Circle: Drawable {
    func draw() {
        print("Drawing a circle")
    }
}

struct Rectangle: Drawable {
    func draw() {
        print("Drawing a rectangle")
    }
}

func getDrawable() -> Drawable {
    return Circle()
}

//it's the same meaning of the one above, it returns boxed type
func getDrawable2() -> any Drawable {
    return Circle()
}



func usage() {
    //you can put different type in the array if they are comform to Drawable protocol
    let drawables: [any Drawable] = [Circle(), Rectangle()]
}
