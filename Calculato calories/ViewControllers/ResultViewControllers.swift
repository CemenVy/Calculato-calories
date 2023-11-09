//
//  ResultViewControllers.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 24.09.2023.
//

import UIKit


final class ResultViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    
    @IBOutlet var basalMetabolicLabel: UILabel!
    @IBOutlet var activityMetabolicLabel: UILabel!
    @IBOutlet var goalMetabolicLabel: UILabel!
    
    @IBOutlet var proteinLabel: UILabel!
    @IBOutlet var fatLabel: UILabel!
    @IBOutlet var carbohydrate: UILabel!
    
    // MARK: - Private Methods
    private let storageManager = StorageManager.shared
    
    // MARK: - Public Methods
    weak var delegate: ResultViewControllerDelegate!
    
    var person: Person!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let action = UIAction { [weak  self] _ in
            guard let name = self?.nameTextField.text else { return }
            self?.saveButton.isEnabled = !name.isEmpty
        }
        nameTextField.addAction(action, for: .editingChanged)
        
        basalMetabolicLabel.text = String(format: "%.0f", person.basalMetabolicRate)
        activityMetabolicLabel.text = String(format: "%.0f", person.activityMetabolicRate)
        goalMetabolicLabel.text = String(format: "%.0f", person.goalMetabolicRate)
        
        proteinLabel.text = String(format: "%.0f", person.protein)
        fatLabel.text = String(format: "%.0f", person.fat)
        carbohydrate.text = String(format: "%.0f", person.carbohydrate)
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func saveButtonPressed(_ sender: UITabBarItem) {
        guard let name = nameTextField.text else { return }
        guard let surname = surnameTextField.text else { return }
        
        person.name = name
        person.surname = surname
        storageManager.save(person: person)
        
        delegate?.add(person: person)
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension ResultViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
}
