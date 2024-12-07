//
//  ViewController.swift
//  IContact
//
//  Created by Damir Chalkarov on 22.11.2024.
//

import UIKit

protocol ContactEditDelegate: AnyObject {
    func didUpdateContact(_ contact: ContactRecord)
}


class ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var initialsContainerView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var undoDeleteButton: UIButton!
    @IBOutlet weak var deleteContactButton: UIButton!
    @IBOutlet weak var messageStackView: UIStackView!
    @IBOutlet weak var callStackView: UIStackView!
    @IBOutlet weak var videoStackView: UIStackView!
    @IBOutlet weak var mailStackView: UIStackView!
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    
    var fullNameText: String?
    var initialsText: String?
    var phoneNumberText: String?
    var phoneNumber: Int?
    
    var name: String?
    var surname: String?
    var number: Int?
    
    var selectedContact: (name: String, surname: String, phoneNumber: Int)?
    
        
    weak var delegate: ContactEditDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        
        navigationItem.rightBarButtonItem = customButton

        messageStackView.layer.cornerRadius = 5
        callStackView.layer.cornerRadius = 5
        videoStackView.layer.cornerRadius = 5
        mailStackView.layer.cornerRadius = 5
        phoneStackView.layer.cornerRadius = 5
        undoDeleteButton.layer.cornerRadius = 5
        deleteContactButton.layer.cornerRadius = 5
        
    }
    
    func toString(number: Int) -> String {
        let phoneNumber = String(number)
        return phoneNumber
    }
    
    
    
    @objc func editButtonTapped() {
        // Логика для нажатия на кнопку
        print("Custom button tapped!")
        
        editInfo()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        initialsContainerView.layer.cornerRadius = initialsContainerView.frame.height / 2
        
        fullNameLabel.text = fullNameText
        initialsLabel.adjustsFontSizeToFitWidth = true
        initialsLabel.minimumScaleFactor = 0.5
        initialsLabel.lineBreakMode = .byClipping
        initialsLabel.textAlignment = .center
        initialsLabel.text = initialsText
        phoneNumberButton.setTitle(phoneNumberText, for: .normal)
    }
    
    @IBAction func callPhoneNumber(_ sender: UIButton) {
        // Убедимся, что номер телефона существует
        guard let phoneNumber = phoneNumberText else {
            print("Номер телефона отсутствует")
            return
        }
        
        // Формируем URL для звонка
        let phoneURL = "tel://\(phoneNumber)"
        if let url = URL(string: phoneURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Не удалось открыть URL для звонка. Возможно, это устройство не поддерживает звонки.")
            }
        }
    }
    
    @IBAction func sendSMSButtonTapped(_ sender: UIButton) {
        guard let phoneNumber = phoneNumberText else {
            print("Номер телефона отсутствует")
            return
        }
        
        let smsURL = "sms:\(phoneNumber)"
        if let url = URL(string: smsURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Не удалось открыть приложение для отправки SMS. Устройство не поддерживает отправку сообщений.")
            }
        }
    }
    
    @IBAction func startFaceTimeCall(_ sender: UIButton) {
        guard let phoneNumber = phoneNumberText else {
            print("Номер телефона отсутствует")
            return
        }
        
        let facetimeURL = "facetime://\(phoneNumber)"
        if let url = URL(string: facetimeURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Не удалось открыть FaceTime. Устройство не поддерживает FaceTime.")
            }
        }
    }
    
    
    func getFirstName() -> String {
        guard let components = fullNameText?.split(separator: " ") else {
            return "" // Вернем пустую строку в случае ошибки
        }
        return String(components[0]) // Преобразуем Substring в String перед возвратом
    }
    
    func getLastName() -> String {
        guard let components = fullNameText?.split(separator: " ") else {
            return "" // Вернем пустую строку в случае ошибки
        }
        print(components[1])
        return String(components[1]) // Преобразуем Substring в String перед возвратом
    }
    
    func editInfo() {
        let alertController = UIAlertController(title: "Edit Contact", message: nil, preferredStyle: .alert)
        
        
        // Добавляем текстовые поля
        alertController.addTextField { textField in
            textField.placeholder = "Name"
            textField.text = self.getFirstName() // Подставляем имя контакта
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Surname"
            textField.text = self.getLastName() // Подставляем фамилию контакта
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Phone Number"
            textField.text = self.phoneNumberText != nil ? String(self.phoneNumberText!) : ""
            textField.keyboardType = .numberPad
            textField.delegate = self // Установка делегата для ограничения ввода
        }
        
        // Добавляем кнопку "Save"
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            if let nameField = alertController.textFields?[0], let surnameField = alertController.textFields?[1], let numberField = alertController.textFields?[2] {
                self.name = nameField.text
                self.surname = surnameField.text
                self.number = Int(numberField.text ?? "0") // Обновляем номер телефона
                
                // Обновляем интерфейс
                self.fullNameText = "\(self.name ?? "") \(self.surname ?? "")"
                self.phoneNumberText = self.number != nil ? String(self.number!) : ""
                // Когда сохраняются данные
                if let name = self.name, let surname = self.surname, !name.isEmpty, !surname.isEmpty {
                    let initials = name.prefix(1) + surname.prefix(1)
                    self.initialsText = initials.uppercased() // Преобразуем в верхний регистр, если нужно
                } else {
                    self.initialsText = "?" // Если имя или фамилия пусты
                }

                
                // Обновляем UI
                self.fullNameLabel.text = self.fullNameText
                self.phoneNumberButton.setTitle(self.phoneNumberText, for: .normal)
            }
        }
        
        // Добавляем кнопку "Cancel"
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Добавляем действия в UIAlertController
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        // Показываем alert
        self.present(alertController, animated: true, completion: nil)
    }


}



