//
//  DetailsViewController.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 28.09.2023.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    
    @IBOutlet var goalLabel: UILabel!
    @IBOutlet var levelActivityLabel: UILabel!
    
    @IBOutlet var basalMetabolicRateLabel: UILabel!
    @IBOutlet var metabolicRateForGoalLabel: UILabel!
    @IBOutlet var metabolicRateForActivityLabel: UILabel!
    
    @IBOutlet var proteinFatCarbsLabel: UILabel!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = person.fullName
        
        genderLabel.text = "Пол: \(person.gender.definition)"
        ageLabel.text = "Возраст: \(String(format: "%.0f", person.age)) лет"
        weightLabel.text = "Вес: \(person.weight) кг."
        heightLabel.text = "Рост: \(person.height) см."
        
        goalLabel.text = "Текущая цель: \(person.goal.definition)"
        levelActivityLabel.text = "Уровень активности: \(person.levelActivity.definition)"
        
        basalMetabolicRateLabel.text = "Базовый объем ккал: \(person.basalMetabolicRate)"
        metabolicRateForGoalLabel.text = "Ккал. под цель: \(person.goalMetabolicRate)"
        metabolicRateForActivityLabel.text = "Ккал. под активность: \(person.activityMetabolicRate)"
        
        proteinFatCarbsLabel.text = "БЖУ: \(String(format: "%.0f", person.protein)), \(String(format: "%.0f", person.fat)), \(String(format: "%.0f", person.carbohydrate))"
        
        
    }

}
