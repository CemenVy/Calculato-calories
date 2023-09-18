//
//  Calculator.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 30.08.2023.
//

import Foundation

struct Calculator {
    let person: Person
    let bMR: BMR
    
    static func getCalculator() -> Double {
        
        let person = Person.getPerson()
        
        var genderCoefficient = 0.0
        var weightCoefficient = 0.0
        var growthCoefficient = 0.0
        var ageCoefficient = 0.0
        
        switch person.gender {
        case .male:
            genderCoefficient = BMR.maleBaseCoefficient.rawValue
            weightCoefficient = BMR.maleWeightCoefficient.rawValue
            growthCoefficient = BMR.maleGrowthCoefficient.rawValue
            ageCoefficient = BMR.maleAgeCoefficient.rawValue
        case .female:
            genderCoefficient = BMR.femaleBaseCoefficient.rawValue
            weightCoefficient = BMR.femaleWeightCoefficient.rawValue
            growthCoefficient = BMR.femaleGrowthCoefficient.rawValue
            ageCoefficient = BMR.femaleAgeCoefficient.rawValue
        }
        
        let levelBasalMetabolic = genderCoefficient + (weightCoefficient * person.weight) + (growthCoefficient * person.growth) + (ageCoefficient * person.age)
        
        return levelBasalMetabolic
    }
}

struct Person {
    var gender: Gender
    var goal: Goal
    var levelActivity: Activity
    var age: Double
    var growth: Double
    var weight: Double
    
    static func getPerson() -> Person {
        Person(gender: .male,
               goal: .gainWeight,
               levelActivity: .low,
               age: 27,
               growth: 180,
               weight: 70
        )
    }
}

enum BMR: Double {
    case maleWeightCoefficient = 13.7
    case maleGrowthCoefficient = 5.0
    case maleAgeCoefficient = 6.8
    case maleBaseCoefficient = 66
    case femaleWeightCoefficient = 9.6
    case femaleGrowthCoefficient = 1.8
    case femaleAgeCoefficient = 4.7
    case femaleBaseCoefficient = 655

}

enum Gender {
    case male
    case female
}

enum Activity: Double {
    case low = 1.2
    case lowPlus = 1.375
    case medium = 1.55
    case high = 1.725
}

enum Goal: Double {
    case keepInShape = 0.8
    case reduceWeight = 1.0
    case gainWeight = 1.2
}

