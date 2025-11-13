//
//  CopyOnWrite.swift
//  Programming
//
//  Created by ke Liu on 11/13/25.
//

struct HTTPRequest {
    fileprivate class Storage {
        var path: String
        var headers: [String: String]
        init(path: String, headers: [String: String]) {
            self.path = path
            self.headers = headers
        }
    }
    
    private var storage: Storage
    
    init(path: String, headers: [String: String]) {
        storage = Storage(path: path, headers: headers)
    }
}

extension HTTPRequest {
    private var storageForWriting: HTTPRequest.Storage {
        mutating get {
            if !isKnownUniquelyReferenced(&storage) {
                self.storage = storage.copy()
            }
            return storage
        }
    }
    
    var path: String {
        get { storage.path }
        set {
            storageForWriting.path = newValue
        }
    }
    var headers: [String: String] {
        get { storage.headers }
        set {
            storageForWriting.headers = newValue
        }
    }
}

extension HTTPRequest.Storage {
    func copy() -> HTTPRequest.Storage {
        print("Making a copy...") // For debugging
        return HTTPRequest.Storage(path: path, headers: headers)
    }
}

func testExample1() {
    var req = HTTPRequest(path: "/home", headers: [:])
    var copy = req
    for x in 0..<5 {
        req.headers["X-RequestId"] = "\(x)"
    }
}
//Making a copy...

//2. willSet break the copy on write optimaziton
struct Wrapper {
    var reqWithNoObservers = HTTPRequest(path: "/", headers: [:])
    var reqWithWillSet = HTTPRequest(path: "/", headers: [:]) {
        willSet {
            print("willSet")
        }
    }
    var reqWithDidSet = HTTPRequest(path: "/", headers: [:]) {
        didSet {
            print("didSet")
        }
    }
}




func testExample2() {
    var wrapper = Wrapper()
    wrapper.reqWithNoObservers.path = "/about"
    wrapper.reqWithDidSet.path = "/forum"
    //didSet
    
    wrapper.reqWithWillSet.path = "/blog"
    //Making a copy...
    //willSet
}
