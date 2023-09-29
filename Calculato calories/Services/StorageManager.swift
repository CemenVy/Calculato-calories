//
//  StorageManager.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 24.09.2023.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    
    private let fileURL = URL.documentsDirectory.appending(path: "Persons").appendingPathExtension("plist")
    
    private init() {}
    
    func fetchPersons() -> [Person] {
        guard let data = try? Data(contentsOf: fileURL) else { return [] }
        guard let persons = try? PropertyListDecoder().decode([Person].self, from: data) else { return [] }
        return persons
    }
    
    func save(person: Person) {
        var persons = fetchPersons()
        persons.append(person)
        
        guard let data = try? PropertyListEncoder().encode(persons) else { return }
        try? data.write(to: fileURL, options: .noFileProtection)
    }
    
    func read() {
        
    }
    
    func update() {
        
    }
    
    func deletePerson(at index: Int) {
        var persons = fetchPersons()
        persons.remove(at: index)
        
        guard let data = try? PropertyListEncoder().encode(persons) else { return }
        try? data.write(to: fileURL, options: .noFileProtection)
    }
}
