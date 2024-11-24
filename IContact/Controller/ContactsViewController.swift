//
//  ContactsViewController.swift
//  IContact
//
//  Created by Damir Chalkarov on 23.11.2024.
//

import UIKit

class ContactsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addActionPressed(_ sender: Any) {
        askForInfo()
    }
    
    func askForInfo() {
        let alertController = UIAlertController(title: "Add Contact", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addTextField()
        
        let saveAction = UIAlertAction(title: "Add", style: .default)
        alertController.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
    }
   

}
