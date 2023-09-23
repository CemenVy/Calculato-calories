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
    
    // MARK: - Private Properties
    private var person = Person(gender: .male, goal: .gainWeight, levelActivity: .high, age: 0, growth: 0, weight: 0)
    
    private let buttonOn: CGFloat = 1
    private let buttonOf: CGFloat = 0.3
    
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

    // MARK: - Private Methods
    private func createMenu(for currentMenu: CurrentMenu) -> UIMenu? {
        let menuTitle = "Выберите вариант"
        var actions: [UIAction] = []
        
        switch currentMenu {
        case .activityMenu:
            actions = Activity.allCases.map { activity in
                UIAction(title: activity.definition) { [weak self] _ in
                    self?.levelActivityMenu.setTitle(activity.definition, for: .normal)
                    self?.updatePerson(levelActivity: activity)
                }
            }
        case .goalMenu:
            actions = Goal.allCases.map { goal in
                UIAction(title: goal.definition) { [weak self] _ in
                    self?.goalMenu.setTitle(goal.definition, for: .normal)
                    self?.updatePerson(goal: goal)
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
            updatePerson(gender: .male)
        default:
            updatePerson(gender: .female)
        }
    }
    
    private func updatePerson(gender: Gender? = nil, goal: Goal? = nil, levelActivity: Activity? = nil, age: Double? = nil, growth: Double? = nil, weight: Double? = nil) {
        if let gender = gender {
            person.gender = gender
        }
        if let goal = goal {
            person.goal = goal
        }
        if let levelActivity = levelActivity {
            person.levelActivity = levelActivity
        }
        if let age = age {
            person.age = age
        }
        if let growth = growth {
            person.growth = growth
        }
        if let weight = weight {
            person.weight = weight
        }
    }
        
    @IBAction func chooseLevelActivityDidTapped(_ sender: UIButton) {
        sender.menu = createMenu(for: .activityMenu)
        
    }
    
    @IBAction func chooseGoalDidTapped(_ sender: UIButton) {
        sender.menu = createMenu(for: .goalMenu)
    }
    
    @IBAction func calculateButtonDidTapped(_ sender: UIButton) {

        
//        Проверяем, выбраны ли цель и активность
//        guard let selectedGoal = person.goal else {
//            showAlert(with: "Ошибка", andMessage: "Пожалуйста, выберите цель перед расчетом.")
//            return
//       }
//        guard let selectedActivity = person.levelActivity else {
//            showAlert(with: "Ошибка", andMessage: "Пожалуйста, выберите уровень активности перед расчетом.")
//            return
//        }
//        guard let selectedGender = person.gender else {
//            showAlert(with: "Ошибка", andMessage: "Пожалуйста, выберите пол перед расчетом.")
//            return
//        }
        
        // Создаем объект Calculator с новым Person
        let calculator = Calculator(person: person)
        
        // Выполняем расчет
        let result = calculator.getCalculator()
        print(result)
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
            updatePerson(age: correctValue)
        case weightTextField:
            updatePerson(weight: correctValue)
        default:
            updatePerson(growth: correctValue)
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

