//
//  ResultViewControllers.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 24.09.2023.
//

import UIKit


final class ResultViewController: UIViewController {
    
    @IBOutlet var basalMetabolicLabel: UILabel!
    @IBOutlet var activityMetabolicLabel: UILabel!
    @IBOutlet var goalMetabolicLabel: UILabel!
    
    @IBOutlet var proteinLabel: UILabel!
    @IBOutlet var fatLabel: UILabel!
    @IBOutlet var carbohydrate: UILabel!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basalMetabolicLabel.text = String(format: "%.0f", person.basalMetabolicRate)
        activityMetabolicLabel.text = String(format: "%.0f", person.activityMetabolicRate)
        goalMetabolicLabel.text = String(format: "%.0f", person.goalMetabolicRate)
        
        proteinLabel.text = String(format: "%.0f", person.protein)
        fatLabel.text = String(format: "%.0f", person.fat)
        carbohydrate.text = String(format: "%.0f", person.carbohydrate)
    }
}
