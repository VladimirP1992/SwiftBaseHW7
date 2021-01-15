//
//  main.swift
//  SwiftBaseHW7
//
//  Created by Владимир Поливников on 15.01.2021.
//

import Foundation

enum HumanBaseError: Error {
    case idNotFound
    case humanIsNotAdult
    case unallowableGender
}

enum Gender {
    case Male, Female
}

struct Human {
    let name: String
    let age: Int
    let gender: Gender
}

class HumanBase {
    private let adultAge = 18
    
    var base = [
        123: Human(name: "Bob", age: 13, gender: .Male),
        456: Human(name: "Mary", age: 19, gender: .Female),
        789: Human(name: "John", age: 23, gender: .Male)
    ]
    
    //For task1 - value or error
    func recruit(humanID : Int) -> (Human?, HumanBaseError?){
        guard let human = base[humanID] else {
            return (nil, .idNotFound)
        }
        
        guard human.age >= adultAge else {
            return (nil, .humanIsNotAdult)
        }
        
        return (human, nil)
    }
    
    //For task2 - throw error
    func recruitFirefighter(humanID : Int) throws -> Human {
        guard let human = base[humanID] else {
            throw HumanBaseError.idNotFound
        }
        
        guard human.age >= adultAge else {
            throw HumanBaseError.humanIsNotAdult
        }
        
        guard human.gender == .Male else {
            throw HumanBaseError.unallowableGender
        }
        
        return human
    }
}

//Task1 test
var humanBase = HumanBase()
var result = humanBase.recruit(humanID: 123)
if let human = result.0 {
    print("Recruited \(human.name)")
} else if let error = result.1 {
    print("Error: \(error)")
}

result = humanBase.recruit(humanID: 76786)
if let human = result.0 {
    print("Recruited \(human.name)")
} else if let error = result.1 {
    print("Error: \(error)")
}

result = humanBase.recruit(humanID: 456)
if let human = result.0 {
    print("Recruited \(human.name)")
} else if let error = result.1 {
    print("Error: \(error)")
}
print()

//Task2 test
do {
    var human = try humanBase.recruitFirefighter(humanID: 789)
    print("Recruited firefighter \(human.name)")
    
    human = try humanBase.recruitFirefighter(humanID: 456)
    print("Unreachable output")
} catch let error {
    print("Error: \(error)")
}
