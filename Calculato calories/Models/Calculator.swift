//
//  Calculator.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 30.08.2023.
//

import Foundation

struct Calculator {
    let person: Person
    
    func getCalculator() -> CalculatorResult {
        
        var bMR = 0.0
        var levelBMRForYourGoal = 0.0
        
        var genderCoefficient = 0.0
        let weightCoefficient = BMR.weightCoefficient.rawValue
        let heightCoefficient = BMR.heightCoefficient.rawValue
        let ageCoefficient = BMR.ageCoefficient.rawValue
        
        switch person.gender {
        case .male:
            genderCoefficient = Gender.male.rawValue
            bMR = weightCoefficient * person.weight + heightCoefficient * person.growth - ageCoefficient * person.age + genderCoefficient
        case .female:
            genderCoefficient = Gender.female.rawValue
            bMR = weightCoefficient * person.weight + heightCoefficient * person.growth - ageCoefficient * person.age - genderCoefficient
        }
        
        let levelBMRForYourActivity =  bMR * person.levelActivity.rawValue
        
        
        switch person.goal {
        case .saveWeight:
            levelBMRForYourGoal = levelBMRForYourActivity
        case .reduceWeight:
            levelBMRForYourGoal = levelBMRForYourActivity - (levelBMRForYourActivity * person.goal.rawValue)
        case .gainWeight:
            levelBMRForYourGoal = levelBMRForYourActivity * person.goal.rawValue
        }
        
        return CalculatorResult(
            levelBasalMetabolic: bMR,
            levelBMRForYourActivity: levelBMRForYourActivity,
            levelBMRForYourGoal: levelBMRForYourGoal
        )
    }
}

struct CalculatorResult{
    let levelBasalMetabolic: Double
    let levelBMRForYourActivity: Double
    let levelBMRForYourGoal: Double
}

struct Person {
    var name: String
    var surname: String
    var gender: Gender
    var goal: Goal
    var levelActivity: Activity
    var age: Double
    var growth: Double
    var weight: Double
    
    var fullname: String {
        "\(name) \(surname)"
    }
    
    mutating func update(gender: Gender, goal: Goal, levelActivity: Activity, age: Double, growth: Double, weight: Double) {
           self.gender = gender
           self.goal = goal
           self.levelActivity = levelActivity
           self.age = age
           self.growth = growth
           self.weight = weight
       }
    
 
}

enum BMR: Double {
    case weightCoefficient = 10
    case heightCoefficient = 6.25
    case ageCoefficient = 5
}

enum Gender: Double {
    case male = 5
    case female = 161
}

enum Activity: Double, CaseIterable {
    case low = 1.2
    case medium = 1.375
    case high = 1.465
    
    var definition: String {
        switch self {
        case .low:
            return "Cовсем нет физических нагрузок"
        case .medium:
            return "Тренируюсь 1-3 раза/неделю"
        case .high:
            return "Тренируюсь 4-5 раз/неделю"
        }
    }
}

enum Goal: Double, CaseIterable {
    case saveWeight = 0.0
    case reduceWeight = 0.20
    case gainWeight = 1.20
    
    var definition: String {
        switch self {
        case .saveWeight:
            return "Сохранить текущий вес"
        case .reduceWeight:
            return "Уменьшить вес"
        case .gainWeight:
            return "Набрать вес"
        }
    }
}

