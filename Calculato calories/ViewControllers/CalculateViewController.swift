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
    
    // MARK: - IB Outlets
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var growthTextField: UITextField!
    
    @IBOutlet var genderSegmentedControl: UISegmentedControl!
    
    @IBOutlet var levelActivityMenu: UIButton!
    @IBOutlet var goalMenu: UIButton!
    @IBOutlet var calculatorButton: UIButton!
    
    // MARK: - Private Properties
    private var person = Person()
    private var currentMenu: CurrentMenu = .activityMenu
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageTextField.delegate = self
        weightTextField.delegate = self
        growthTextField.delegate = self
        
        levelActivityMenu.layer.cornerRadius = 10
        goalMenu.layer.cornerRadius = 10
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.person = person
    }
    
    // MARK: - Private Methods
    private func createMenu(for currentMenu: CurrentMenu) -> UIMenu? {
        let menuTitle = "Выберите вариант"
        var actions: [UIAction] = []
        
        switch currentMenu {
        case .activityMenu:
            actions = Activity.allCases.map { activity in
                UIAction(title: activity.definition) { [weak self] _ in
                    self?.levelActivityMenu.setTitle(activity.definition, for: .normal)
                    self?.person.levelActivity = activity
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
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert,animated: true)
    }
    
    // MARK: - IB Actions
    @IBAction func chooseGenderDidTapped() {
        switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            person.gender = .male
        default:
            person.gender = .female
        }
    }
    
    @IBAction func chooseLevelActivityDidTapped(_ sender: UIButton) {
        sender.menu = createMenu(for: .activityMenu)
        
    }
    
    @IBAction func chooseGoalDidTapped(_ sender: UIButton) {
        sender.menu = createMenu(for: .goalMenu)
    }
    
    @IBAction func calculateButtonDidTapped() {
        let calculator = Calculator.getCalculator(person)
        person.basalMetabolicRate = calculator.basalMetabolicRate
        person.activityMetabolicRate = calculator.activityMetabolicRate
        person .goalMetabolicRate = calculator.goalMetabolicRate
        person.protein = calculator.protein
        person.fat = calculator.fat
        person.carbohydrate = calculator.carbohydrate
    }
}
// MARK: - UI Text Field Delegate
extension CalculateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text  else  {
            showAlert(with: "Внимание!", andMessage: "Пожалуйста введите корректное значение.")
            return
        }
        guard let correctValue = Double(text), (0...250).contains(correctValue) else {
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
            person.height = correctValue
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem:.done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}

