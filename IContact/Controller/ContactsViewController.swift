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
        let alertController = UIAlertController(title: "Add Contact", message: nil, preferredStyle: .alert) // добавление окна для добавления информации о контакте
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        } //добавление поле
        alertController.addTextField { textField in
            textField.placeholder = "Last name"
        } //добавление поле
        alertController.addTextField { textField in
            textField.placeholder = "Number"
        } //добавление поле
        
        let saveAction = UIAlertAction(title: "Add", style: .default) { _ in
            
            guard let nameField = alertController.textFields?[0] else {
                return //безопасное извлечение имени
            }
            
            guard let surnameField = alertController.textFields?[1] else {
                return //безопасное извлечение фамилии
            }
            
            guard let nameText = nameField.text, !nameText.isEmpty,
                  let surNameText = surnameField.text, !surNameText.isEmpty else {
                print("One or both fields are empty")
                return
                //безопасная проверка на наличие текста в обоих полях
            }
            print(nameText, surNameText)

        }
        alertController.addAction(saveAction)
        //выше логика для кнопки сохранения информации
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        //выше кнопка для отмены
        
        present(alertController, animated: true)
        //показ окна добавления информации
    }
   

}
