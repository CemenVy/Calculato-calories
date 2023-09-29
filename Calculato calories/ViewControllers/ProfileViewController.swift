//
//  ProfileViewController.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 30.08.2023.
//

import UIKit

protocol ResultViewControllerDelegate: AnyObject {
    func add(person: Person)
}

final class ProfileViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var persons: [Person] = []
    private let storageManager = StorageManager.shared
    
    // MARK: - View Life Cycles
    override func viewDidAppear(_ animated: Bool) {
        persons = storageManager.fetchPersons()
        tableView.reloadData()
    }
    
    // MARK: - UITAbleViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath)
        let person = persons[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = person.fullName
        content.secondaryText = DateFormatter.localizedString(from: person.date, dateStyle: .medium, timeStyle: .none)
        
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            persons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            storageManager.deletePerson(at: indexPath.row)
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let detailsVC = segue.destination as? DetailsViewController
        detailsVC?.person = persons[indexPath.row]
    }
}

    // MARK: - ResultViewControllerDelegate
extension ProfileViewController: ResultViewControllerDelegate {
    func add(person: Person) {
        persons.append(person)
        tableView.reloadData()
    }
}
