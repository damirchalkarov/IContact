//
//  ContactsViewController.swift
//  IContact
//
//  Created by Damir Chalkarov on 23.11.2024.
//

import UIKit

class ContactsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var number: Int = 123
    
    static let contactKey: String = "contact"
    
    var contactsArrayOfDictionaries: [[String: Any]] = [] {
        didSet {
            print("value of variable 'contactsArrayOfDictionaries' was changed") //обновляем таблицу при переопределении переменной
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: ContactTableViewCell.identifier) //регистрация таблицы и ячейки с идентификатором
        tableView.dataSource = self
        tableView.delegate = self
        
        getContact()
        
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
            
            guard let numberField = alertController.textFields?[2] else {
                return //безопасное извлечение имени
            }
            
            guard let nameText = nameField.text, !nameText.isEmpty,
                  let surNameText = surnameField.text, !surNameText.isEmpty,
                  let phoneNumber = numberField.text, !phoneNumber.isEmpty else {
                print("One or all fields are empty")
                return
                //безопасная проверка на наличие текста в обоих полях
            }
            
            guard let number = Int(phoneNumber) else {return} //проверка на то, чтобы введенные данные были цифрами
            
            self.number = number // переопределение переменной number
            
            let fullName = "\(nameText) \(surNameText)" //объединение имени и фамилии
            
            print(fullName)
            
            self.saveContact(name: fullName) // вызов функции и передача аргумента fullname
            
        }
        alertController.addAction(saveAction)
        //выше логика для кнопки сохранения информации
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        //выше кнопка для отмены
        
        present(alertController, animated: true)
        //показ окна добавления информации
    }
    
    //порядок работы функций
    
    
    //1
    func saveContact(name: String) {
        let contact: [String: Any] = ["name": name, "number": number] //создание словаря
        let contactArray: [[String: Any]] = getContactsArray() + [contact] //создание массива, который хранит в себе словари
        let userDefaults = UserDefaults.standard // создание хранилища
        userDefaults.set(contactArray, forKey: ContactsViewController.contactKey) //запись в словарь
        
        getContact()
    }
    
    //2
    func getContactsArray() -> [[String: Any]] {
        let userDefaults = UserDefaults.standard
        let array = userDefaults.array(forKey: ContactsViewController.contactKey) as? [[String: Any]]
        return array ?? []
        
        //создания массива из данных с хранилища
    }
    
    //3
    func getContact() {
        let userDefaults = UserDefaults.standard //объявление хранилища
        guard let contact = userDefaults.array(forKey: ContactsViewController.contactKey) else {
            print("UserDefaults doesn't contain array with key : contact")
            return
        } //извлечение из хранилища данных
        
        guard let contactsArrayOfDictionaries = contact as? [[String: Any]] else {
            print("Couldn't convert [Any] to [[String: Any]]")
            return
            //безопасное создание массива
        }
        
        print(contact, "contactsArrayOfDictionaries: \(contactsArrayOfDictionaries)")
        
        self.contactsArrayOfDictionaries = contactsArrayOfDictionaries
        
    }
    

}


//логика таблицы
extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //первый обязательный метол UITableView
        return contactsArrayOfDictionaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //второй обязательный метол UITableView
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
   
        let dictionary: [String: Any] = contactsArrayOfDictionaries[indexPath.row] //создание словаря
        if let name = dictionary["name"] as? String {
            cell.contactTextLabel.text = "\(name)"  //извлекаем ключ, так как нам нужен только ключ на данный момент, без значения
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
