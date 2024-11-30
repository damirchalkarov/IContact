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
    
    let fullAlphabet: [Character] = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    static let contactKey: String = "contact"
    
    var dataSource: [[ContactRecord]] = [] {
        didSet {
            print("value of variable 'dataSource' was changed") //обновляем таблицу при переопределении переменной
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
            
//            print(fullName)
            
//            self.saveContact(name: fullName) // вызов функции и передача аргумента fullname
            self.saveContactRecordAsStruct(name: fullName)
            self.getContact()
            
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
//        let userDefaults = UserDefaults.standard //объявление хранилища
//        guard let contact = userDefaults.array(forKey: ContactsViewController.contactKey) else {
//            print("UserDefaults doesn't contain array with key : contact")
//            return
//        } //извлечение из хранилища данных
//        
//        guard let contactsArrayOfDictionaries = contact as? [[String: Any]] else {
//            print("Couldn't convert [Any] to [[String: Any]]")
//            return
//            //безопасное создание массива
//        }
        
//        print(contact, "contactsArrayOfDictionaries: \(contactsArrayOfDictionaries)")
        
//        self.contactsArrayOfDictionaries = getAllContactsRecords()
        
        let aContactList = getAllContactsRecords(letter: .a)
        let bContactList = getAllContactsRecords(letter: .b)
        let cContactList = getAllContactsRecords(letter: .c)
        let dContactList = getAllContactsRecords(letter: .d)
        let eContactList = getAllContactsRecords(letter: .e)
        let fContactList = getAllContactsRecords(letter: .f)
        let gContactList = getAllContactsRecords(letter: .g)
        let hContactList = getAllContactsRecords(letter: .h)
        let iContactList = getAllContactsRecords(letter: .i)
        let jContactList = getAllContactsRecords(letter: .j)
        let kContactList = getAllContactsRecords(letter: .k)
        let lContactList = getAllContactsRecords(letter: .l)
        let mContactList = getAllContactsRecords(letter: .m)
        let nContactList = getAllContactsRecords(letter: .n)
        let oContactList = getAllContactsRecords(letter: .o)
        let pContactList = getAllContactsRecords(letter: .p)
        let qContactList = getAllContactsRecords(letter: .q)
        let rContactList = getAllContactsRecords(letter: .r)
        let sContactList = getAllContactsRecords(letter: .s)
        let tContactList = getAllContactsRecords(letter: .t)
        let uContactList = getAllContactsRecords(letter: .u)
        let vContactList = getAllContactsRecords(letter: .v)
        let wContactList = getAllContactsRecords(letter: .w)
        let xContactList = getAllContactsRecords(letter: .x)
        let yContactList = getAllContactsRecords(letter: .y)
        let zContactList = getAllContactsRecords(letter: .z)
        
        self.dataSource = [aContactList, bContactList, cContactList, dContactList, eContactList, fContactList, gContactList, hContactList, iContactList, jContactList, kContactList, lContactList, mContactList, nContactList, oContactList, pContactList, qContactList, rContactList, sContactList, tContactList, uContactList, vContactList, wContactList, xContactList, yContactList, zContactList]
        
    }
    
    func saveContactRecordAsStruct(name: String) {
        let contact: ContactRecord = ContactRecord(name: name, number: number)
        
        var letter: Letter?
        
        guard let firstLetter = contact.name.first?.lowercased() else {
            print("Имя пустое или не начинается с буквы")
            return
        }
        
        switch firstLetter {
            case "a": letter = .a
            case "b": letter = .b
            case "c": letter = .c
            case "d": letter = .d
            case "e": letter = .e
            case "f": letter = .f
            case "g": letter = .g
            case "h": letter = .h
            case "i": letter = .i
            case "j": letter = .j
            case "k": letter = .k
            case "l": letter = .l
            case "m": letter = .m
            case "n": letter = .n
            case "o": letter = .o
            case "p": letter = .p
            case "q": letter = .q
            case "r": letter = .r
            case "s": letter = .s
            case "t": letter = .t
            case "u": letter = .u
            case "v": letter = .v
            case "w": letter = .w
            case "x": letter = .x
            case "y": letter = .y
            case "z": letter = .z
            default: letter = nil
        }
        
        guard let letter = letter else {
            return
        }
        
        //получение всех раннее сохраненных записей
        let contactsRecordsArray: [ContactRecord] = getAllContactsRecords(letter: letter) + [contact]
        
        do {
            
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(contactsRecordsArray)
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(encodedData, forKey: letter.key())
            
        } catch {
            print("Couldn't encode given [ContactRecord] into data with error: \(error.localizedDescription)")
        }
    }
    
    func getAllContactsRecords(letter: Letter) -> [ContactRecord] {
        var result: [ContactRecord] = []
        
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: letter.key())
            as? Data {
            
            do {
                
                let decoder = JSONDecoder()
                result = try decoder.decode([ContactRecord].self, from: data)
                
            } catch {
                print("Couldn't decode given data to [ContactRecord] with error: \(error.localizedDescription)")
            }
            
        }
        
        return result
    }
}


//логика таблицы
extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //первый обязательный метол UITableView
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //второй обязательный метол UITableView
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
   
        let contactRecord: ContactRecord = dataSource[indexPath.section][indexPath.row] //создание словаря
      
        cell.contactTextLabel.text = contactRecord.name //извлекаем ключ, так как нам нужен только ключ на данный момент, без значения

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: return "A"
            case 1: return "B"
            case 2: return "C"
            case 3: return "D"
            case 4: return "E"
            case 5: return "F"
            case 6: return "G"
            case 7: return "H"
            case 8: return "I"
            case 9: return "J"
            case 10: return "K"
            case 11: return "L"
            case 12: return "M"
            case 13: return "N"
            case 14: return "O"
            case 15: return "P"
            case 16: return "Q"
            case 17: return "R"
            case 18: return "S"
            case 19: return "T"
            case 20: return "U"
            case 21: return "V"
            case 22: return "W"
            case 23: return "X"
            case 24: return "Y"
            case 25: return "Z"
            default: return "Invalid Input"
        }

    }
    
}


struct ContactRecord: Codable {
    let name: String
    let number: Int
}

enum Letter: CaseIterable {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    case i
    case j
    case k
    case l
    case m
    case n
    case o
    case p
    case q
    case r
    case s
    case t
    case u
    case v
    case w
    case x
    case y
    case z
    
    func key() -> String {
        switch self {
            case .a: "a"
            case .b: "b"
            case .c: "c"
            case .d: "d"
            case .e: "e"
            case .f: "f"
            case .g: "g"
            case .h: "h"
            case .i: "i"
            case .j: "j"
            case .k: "k"
            case .l: "l"
            case .m: "m"
            case .n: "n"
            case .o: "o"
            case .p: "p"
            case .q: "q"
            case .r: "r"
            case .s: "s"
            case .t: "t"
            case .u: "u"
            case .v: "v"
            case .w: "w"
            case .x: "x"
            case .y: "y"
            case .z: "z"
        }
    }
}

