//
//  ViewController.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 30.08.2023.
//

import UIKit

enum CurrentMenu {
    case activityMenu
    case goalMenu
}

final class CalculateViewController: UIViewController {
    
    @IBOutlet var maleButton: UIButton!
    @IBOutlet var femaleButton: UIButton!
    
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var growthTextField: UITextField!
    
    @IBOutlet var levelActivityMenu: UIButton!
    @IBOutlet var goalMenu: UIButton!
    
    private var person:Person!
    
    private let buttonOn: CGFloat = 1
    private let buttonOf: CGFloat = 0.3
    
    private var currentMenu: CurrentMenu = .activityMenu
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageTextField.delegate = self
        weightTextField.delegate = self
        growthTextField.delegate = self
        
        levelActivityMenu.layer.cornerRadius = 10
        goalMenu.layer.cornerRadius = 10
    }
    
    private func createMenu(for currentMenu: CurrentMenu) -> UIMenu? {
        let menuTitle = "Выберите вариант"
        var actions: [UIAction] = []
        
        switch currentMenu {
        case .activityMenu:
            actions = Activity.allCases.map { activity in
                UIAction(title: activity.definition) { [weak self] _ in
                    self?.levelActivityMenu.setTitle(activity.definition, for: .normal)
                    self?.person?.levelActivity = activity
                }
            }
        case .goalMenu:
            actions = Goal.allCases.map { goal in
                UIAction(title: goal.definition) { [weak self] _ in
                    self?.goalMenu.setTitle(goal.definition, for: .normal)
                    self?.person.goal = goal
                }
            }
        }
        
        let menu = UIMenu(title: menuTitle, children: actions)
        return menu
    }
    
    private func showAlert(with title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert,animated: true)
    }
    
    @IBAction func chooseGenderDidTapped(_ sender: UIButton) {
        switch sender {
        case maleButton:
            person.gender = .male
            femaleButton.alpha = buttonOf
            maleButton.alpha = buttonOn
        default:
            person.gender = .female
            maleButton.alpha = buttonOf
            femaleButton.alpha = buttonOn
        }
    }
    
    @IBAction func chooseLevelActivityDidTapped(_ sender: UIButton) {
        sender.menu = createMenu(for: .activityMenu)
        
    }
    
    @IBAction func chooseGoalDidTapped(_ sender: UIButton) {
        sender.menu = createMenu(for: .goalMenu)
    }
    
    @IBAction func calculateButtonDidTapped(_ sender: UIButton) {
    }
}

extension CalculateViewController: UITextFieldDelegate {
    func resignFirstResponder(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text  else  {
            showAlert(with: "Внимание!", andMessage: "Пожалуйста введите корректное значение.")
            return
        }
        guard let correctValue = Double(text), (0.0...250.0).contains(correctValue) else {
            showAlert(with: "Не верный формат!",
                      andMessage: "Пожалуйста в видите число которое соответствует вашим параметрам.",
                      textField: textField
            )
            return
        }
        
        switch textField {
        case ageTextField:
            person.age = correctValue
        case weightTextField:
            person.weight = correctValue
        default:
            person.growth = correctValue
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

