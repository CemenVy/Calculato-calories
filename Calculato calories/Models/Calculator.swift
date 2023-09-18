//
//  Calculator.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 30.08.2023.
//

import Foundation

struct Calculator {
    let person: Person
    
    func getCalculator() -> Double {
        
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
    
    init(gender: Gender, goal: Goal, levelActivity: Activity, age: Double, growth: Double, weight: Double) {
        self.gender = gender
        self.goal = goal
        self.levelActivity = levelActivity
        self.age = age
        self.growth = growth
        self.weight = weight
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

enum Activity: Double, CaseIterable {
    case low = 1.2
    case lowPlus = 1.375
    case medium = 1.55
    case high = 1.725
    
    var definition: String {
        switch self {
        case .low:
            return "Не тренируюсь"
        case .lowPlus:
            return "Редко тренируюсь"
        case .medium:
            return "Регулярно тренируюсь"
        case .high:
            return "Профессиональный спортсмен"
        }
    }
}

enum Goal: Double, CaseIterable {
    case keepInShape = 0.8
    case reduceWeight = 1.0
    case gainWeight = 1.2
    
    var definition: String {
        switch self {
        case .keepInShape:
            return "Уменьшить вес"
        case .reduceWeight:
            return "Сохранить текущий вес"
        case .gainWeight:
            return "Набрать вес"
        }
    }
}

