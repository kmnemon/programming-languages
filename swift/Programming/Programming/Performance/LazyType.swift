//
//  Lazy.swift
//  Programming
//
//  Created by ke on 2025/2/6.
//

struct LazyType {}

extension LazyType {
    class Singer {
        let name: String
        
        init(name: String) {
            self.name = name
        }
        
        //1.lazy property - lazy closures
        lazy var reversedName: String = {
            return "\(self.name.localizedUppercase) backwards is \(String(self.name.localizedUppercase.reversed()))!"
        }()
        
        //2.lazy function
        /*
         A common complaint people have when using lazy is that it clutters up their code: rather than having a neat separation of properties and methods, lazy properties become a gray area where properties and functionality mix together. There is a simple solution to this: create methods to separate your lazy properties from the code they rely on.
         */
        lazy var reversedName2: String = self.getReversedName2()
        
        private func getReversedName2() -> String {
            return "\(self.name.localizedUppercase) backwards is \(String(self.name.localizedUppercase.reversed()))!"
        }
    }

    
    
    
}
