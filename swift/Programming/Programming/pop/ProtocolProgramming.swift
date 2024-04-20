//
//  ProtocolProgramming.swift
//  Programming
//
//  Created by ke on 2024/4/20.
//

import Foundation

protocol Payable {
    func calculateWages() -> Int
}
extension Payable {
    func calculateWages() -> Int {
        return 10000
    }
}

protocol ProvidesTreatment {
    func treat(name: String)
}
extension ProvidesTreatment {
    func treat(name: String) {
        print("I have treated \(name)")
    }
}

protocol ProvidesDiagnosis {
    func diagnose() -> String
}
extension ProvidesDiagnosis {
    func diagnose() -> String {
        return "He's dead, Jim"
    }
}

protocol ConductsSurgery {
    func performSurgery()
}
extension ConductsSurgery {
    func performSurgery() {
        print("Success!")
    }
}

protocol HasRestTime {
    func takeBreak()
}
extension HasRestTime {
    func takeBreak() {
        print("Time to watch TV")
    }
}

protocol NeedsTraining {
    func study()
}
extension NeedsTraining {
    func study() {
        print("I'm reading a book")
    }
}

protocol Employee: Payable, HasRestTime, NeedsTraining {}
extension Employee where Self: ProvidesTreatment {
    func checkInsurance() {
        print("Yup, I'm totally insured")
    }
}


struct Receptionist { }
struct Nurse { }
struct Doctor { }
struct Surgeon { }

extension Receptionist: Employee {}
extension Nurse: Employee, ProvidesTreatment {}
extension Doctor: Employee, ProvidesDiagnosis, ProvidesTreatment {}
extension Surgeon: Employee, ProvidesDiagnosis, ConductsSurgery {}
