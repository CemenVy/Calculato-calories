//
//  Calculator.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 30.08.2023.
//

import Foundation

struct Person: Codable {
    var name: String
    var surname: String
    var gender: Gender
    var age: Double
    var weight: Double
    var height: Double
    var goal: Goal
    var levelActivity: Activity
    var basalMetabolicRate: Double
    var activityMetabolicRate: Double
    var goalMetabolicRate: Double
    var protein: Double
    var fat: Double
    var carbohydrate: Double
    var date: Date
    
    var fullName: String {
       "\(name) \(surname)"
    }
    
    init(
            name: String = "",
            surname: String = "",
            gender: Gender = .male,
            age: Double = 0.0,
            weight: Double = 0.0,
            height: Double = 0.0,
            goal: Goal = .saveWeight,
            levelActivity: Activity = .low,
            basalMetabolicRate: Double = 0.0,
            activityMetabolicRate: Double = 0.0,
            goalMetabolicRate: Double = 0.0,
            protein: Double = 0.0,
            fat: Double = 0.0,
            carbohydrate: Double = 0.0,
            date: Date = Date()
        ) {
            self.name = name
            self.surname = surname
            self.gender = gender
            self.age = age
            self.weight = weight
            self.height = height
            self.goal = goal
            self.levelActivity = levelActivity
            self.basalMetabolicRate = basalMetabolicRate
            self.activityMetabolicRate = activityMetabolicRate
            self.goalMetabolicRate = goalMetabolicRate
            self.protein = protein
            self.fat = fat
            self.carbohydrate = carbohydrate
            self.date = date
        }
}

struct Calculator {
    let person: Person
    
    static func getCalculator(_ person: Person) -> MetabolicRate {
        
        var basalMetabolicRate = 0.0
        var metabolicRateForGoal = 0.0
        var metabolicRateForActivity = 0.0
        
        var protein = 0.0
        var fat = 0.0
        var carbohydrate = 0.0
        
        let ageCoefficient = Coefficient.age.rawValue
        let weightCoefficient = Coefficient.weight.rawValue
        let heightCoefficient = Coefficient.height.rawValue
        var genderCoefficient = 0.0
       
        switch person.gender {
        case .male:
            genderCoefficient = Gender.male.rawValue
            basalMetabolicRate = weightCoefficient * person.weight + heightCoefficient * person.height - ageCoefficient * person.age + genderCoefficient
        case .female:
            genderCoefficient = Gender.female.rawValue
            basalMetabolicRate = weightCoefficient * person.weight + heightCoefficient * person.height - ageCoefficient * person.age - genderCoefficient
        }
        
        metabolicRateForActivity =  basalMetabolicRate * person.levelActivity.rawValue
        
        switch person.goal {
        case .saveWeight:
            metabolicRateForGoal = metabolicRateForActivity
        case .reduceWeight:
            metabolicRateForGoal = metabolicRateForActivity - (metabolicRateForActivity * person.goal.rawValue)
        case .gainWeight:
            metabolicRateForGoal = metabolicRateForActivity * person.goal.rawValue
        }
        
        // Соотношение белков к объему калорий 30%, 1 гр. белка = 4 калория
        protein = metabolicRateForGoal * 0.30 / 4
        // Соотношение жиров к объему калорий 30%, 1 гр. жиров = 9 калория
        fat = metabolicRateForGoal * 0.30 / 9
        // Соотношение углеводов к объему калорий 30%, 1 гр. углеводов = 4 калория
        carbohydrate = metabolicRateForGoal * 0.40 / 4
        
       let metabolicRates = MetabolicRate(
        basalMetabolicRate: basalMetabolicRate,
        activityMetabolicRate: metabolicRateForActivity,
        goalMetabolicRate: metabolicRateForGoal,
        protein: protein,
        fat: fat,
        carbohydrate: carbohydrate
       )
        
        return metabolicRates
    }
}

struct MetabolicRate {
    let basalMetabolicRate: Double
    let activityMetabolicRate: Double
    let goalMetabolicRate: Double
    let protein: Double
    let fat: Double
    let carbohydrate: Double
}

enum Coefficient: Double {
    case weight = 10
    case height = 6.25
    case age = 5
}

enum Gender: Double, Codable {
    case male = 5
    case female = 161
}

enum Activity: Double, CaseIterable, Codable {
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

enum Goal: Double, CaseIterable, Codable {
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

