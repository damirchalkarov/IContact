//
//  ContactsViewController.swift
//  IContact
//
//  Created by Damir Chalkarov on 23.11.2024.
//

import UIKit

class ContactsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    
    var number: Int = 0
    
    var isSortedBySurname: Bool = false
    
    let fullAlphabet: [Character] = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    static let contactKey: String = "contact"
    
    var dataSource: [[ContactRecord]] = [] {
        didSet {
//            print("value of variable 'dataSource' was changed") //обновляем таблицу при переопределении переменной
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
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        if selectedIndex == 1 {
            isSortedBySurname = true
            
            // Меняем местами имя и фамилию
            dataSource = dataSource.map { section in
                section.map { contact in
                    let components = contact.name.split(separator: " ")
                    if components.count == 2 {
                        let reversedName = "\(components[1]) \(components[0])"
                        return ContactRecord(name: reversedName, number: contact.number)
                    }
                    return contact
                }
            }
            
            // Пересортировываем dataSource по фамилии
            dataSource = sortContactsByFirstLetter(of: .surname, contacts: dataSource.flatMap { $0 })
            
        } else {
            isSortedBySurname = false
            // Возвращаем к сортировке по имени
            getContact()
        }
        
        tableView.reloadData() // Обновляем таблицу
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
                return 
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
    
    //3
    func getContact() {
            var newDataSource: [[ContactRecord]] = Array(repeating: [], count: Letter.allCases.count)
            
            for letter in Letter.allCases {
                let sectionIndex = letter.index()
                let contactList = getAllContactsRecords(letter: letter)
//                print(contactList)
                newDataSource[sectionIndex] = contactList
            }
            
            self.dataSource = newDataSource
    }
    
    func saveContactRecordAsStruct(name: String) {
        let contact: ContactRecord = ContactRecord(name: name, number: number)
        
        var letter: Letter?
        
        guard let firstLetter = contact.name.first?.lowercased() else {
            print("Имя пустое или не начинается с буквы")
            return
        }
        
        print(firstLetter)
        
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
    
    func removeContact(_ contact: ContactRecord, from tableView: UITableView, at indexPath: IndexPath) {
        // Определяем, используется ли сортировка по фамилии
        let originalName: String
        if isSortedBySurname {
            // Если сортировка по фамилии, меняем порядок обратно на "Имя Фамилия"
            let components = contact.name.split(separator: " ")
            if components.count == 2 {
                originalName = "\(components[1]) \(components[0])"
            } else {
                originalName = contact.name
            }
        } else {
            // Если сортировка по имени, используем текущий формат
            originalName = contact.name
        }
        
        // Получаем первую букву из оригинального имени
        guard let firstLetter = originalName.first?.lowercased(),
              let letter = Letter(rawValue: firstLetter) else {
            print("Ошибка: не удалось получить первую букву имени.")
            return
        }

        // Получаем список контактов из UserDefaults для этой буквы
        var contacts = getAllContactsRecords(letter: letter)

        // Удаляем контакт из списка
        if let index = contacts.firstIndex(where: { $0.name == originalName && $0.number == contact.number }) {
            contacts.remove(at: index)

            // Сохраняем обновленный список в UserDefaults
            do {
                let encoder = JSONEncoder()
                let encodedData = try encoder.encode(contacts)
                let userDefaults = UserDefaults.standard
                userDefaults.setValue(encodedData, forKey: letter.key())
            } catch {
                print("Ошибка кодирования контактов: \(error.localizedDescription)")
            }
            
            // Обновляем данные в dataSource
            dataSource[indexPath.section].remove(at: indexPath.row)
            
            // Обновляем таблицу, удаляя только строку
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            print("Контакт не найден.")
        }
    }
    
    func getPhoneNumberText(indexPath: IndexPath) -> String? {
        
        let contactRecord: ContactRecord = dataSource[indexPath.section][indexPath.row]
        let text = "\(contactRecord.number)"
       
        return text
        
    }

    func getFullNameText(indexPath: IndexPath) -> String? {
        
        let contactRecord: ContactRecord = dataSource[indexPath.section][indexPath.row]
        let text = "\(contactRecord.name)"
        
        if SegmentedControl.selectedSegmentIndex == 1 {
            let components = text.split(separator: " ")
            if components.count == 2 {
                let name = "\(components[1]) \(components[0])"
                return name
            }
        }
        return text
        
    }
    
    func getInitialsText(indexPath: IndexPath) -> String? {
        var initials = ""
        let contactRecord: ContactRecord = dataSource[indexPath.section][indexPath.row]
        let text = "\(contactRecord.name)"
        
        
        if SegmentedControl.selectedSegmentIndex == 1 {
            let components = text.split(separator: " ")
            if components.count == 2 {
                let name = "\(components[1])\(components[0])"
                for letter in name {
                    if letter.isUppercase {
                        initials += String(letter)
                    }
                }
                return initials
            }
        }

        for letter in text {
            if letter.isUppercase {
                initials += String(letter)
            }
        }
        
        return initials
    }

}

//логика таблицы
extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //первый обязательный метод UITableView
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
//        
        if let navigationController = navigationController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                navigationController.pushViewController(viewController, animated: true)
                
                viewController.fullNameText = getFullNameText(indexPath: indexPath)
                viewController.initialsText = getInitialsText(indexPath: indexPath)
                viewController.phoneNumberText = getPhoneNumberText(indexPath: indexPath)
                viewController.delegate = self
                viewController.contactIndexPath = indexPath
            } else {
                print("Could not instantiate ViewController")
            }
        } else {
            print("navigationController is nil")
        }
        
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let letter = Letter.allCases[safe: section] else {return nil}
        
        return letter.key().uppercased()

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Удаляем контакт из источника данных
                let contactToRemove = dataSource[indexPath.section][indexPath.row]
                
                // Удаляем контакт из UserDefaults и таблицы
                tableView.beginUpdates()
                removeContact(contactToRemove, from: tableView, at: indexPath)
                tableView.endUpdates()
            }
        }
}

struct ContactRecord: Codable {
    let name: String
    let number: Int
}

enum Letter: CaseIterable {
    case a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
    
    func key() -> String {
        return String(describing: self)
    }
    
    func index() -> Int {
        return Letter.allCases.firstIndex(of: self) ?? 0
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "a": self = .a
        case "b": self = .b
        case "c": self = .c
        case "d": self = .d
        case "e": self = .e
        case "f": self = .f
        case "g": self = .g
        case "h": self = .h
        case "i": self = .i
        case "j": self = .j
        case "k": self = .k
        case "l": self = .l
        case "m": self = .m
        case "n": self = .n
        case "o": self = .o
        case "p": self = .p
        case "q": self = .q
        case "r": self = .r
        case "s": self = .s
        case "t": self = .t
        case "u": self = .u
        case "v": self = .v
        case "w": self = .w
        case "x": self = .x
        case "y": self = .y
        case "z": self = .z
        default: return nil
        }
    }
}

enum SortBy {
    case name
    case surname
}

func sortContactsByFirstLetter(of type: SortBy, contacts: [ContactRecord]) -> [[ContactRecord]] {
    // Инициализируем пустой массив секций
    var sortedSections: [[ContactRecord]] = Array(repeating: [], count: Letter.allCases.count)
    
    for contact in contacts {
        // Выбираем имя или фамилию для сортировки
        let keyText: String
        if type == .surname {
            // Разделяем имя и фамилию, если они существуют
            let components = contact.name.split(separator: " ")
            keyText = components.count == 2 ? String(components[0]) : contact.name // Фамилия
        } else {
            keyText = contact.name // Имя
        }
        
        guard let firstChar = keyText.first?.lowercased(),
              let letter = Letter(rawValue: firstChar) else {
            continue
        }
        
        let sectionIndex = letter.index()
        sortedSections[sectionIndex].append(contact)
    }
    
    return sortedSections
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    
}
extension ContactsViewController: ContactEditDelegate {
    func didUpdateContact(_ contact: ContactRecord, at indexPath: IndexPath) {
        dataSource[indexPath.section][indexPath.row] = contact
        
        if isSortedBySurname {
            dataSource = sortContactsByFirstLetter(of: .surname, contacts: dataSource.flatMap { $0 })
        } else {
            dataSource = sortContactsByFirstLetter(of: .name, contacts: dataSource.flatMap { $0 })
        }
        
        saveAllContactsRecords()
        tableView.reloadData()
    }
    
    func didDeleteContact(at indexPath: IndexPath) {
        dataSource[indexPath.section].remove(at: indexPath.row)
        
        if isSortedBySurname {
            dataSource = sortContactsByFirstLetter(of: .surname, contacts: dataSource.flatMap { $0 })
        } else {
            dataSource = sortContactsByFirstLetter(of: .name, contacts: dataSource.flatMap { $0 })
        }
        
        saveAllContactsRecords()
        tableView.reloadData()
    }
    
    func saveAllContactsRecords() {
        for (sectionIndex, section) in dataSource.enumerated() {
            let letter = Letter.allCases[sectionIndex]
            do {
                let encoder = JSONEncoder()
                let encodedData = try encoder.encode(section)
                let userDefaults = UserDefaults.standard
                userDefaults.setValue(encodedData, forKey: letter.key())
            } catch {
                print("Couldn't encode contacts for section \(sectionIndex) with error: \(error.localizedDescription)")
            }
        }
    }
}









