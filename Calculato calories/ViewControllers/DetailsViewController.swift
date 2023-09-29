//
//  DetailsViewController.swift
//  Calculato calories
//
//  Created by Семен Выдрин on 28.09.2023.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet var bioPersonLabel: UILabel!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = person.fullName
    }

}
