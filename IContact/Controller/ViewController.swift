//
//  ViewController.swift
//  IContact
//
//  Created by Damir Chalkarov on 22.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    var selectedContact: (name: String, surname: String, phoneNumber: Int)?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
            
            // Добавляем кнопку в правую часть панели навигации
            navigationItem.rightBarButtonItem = customButton
        
//        selectedContact = (self., "Doe", "123456789")

        
        
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
    
//    func getName(contactName: String) -> String? {
//        guard let components = fullNameText?.split(separator: " ") else { return nil }
//        let name = "\(components[0])"
//        contactName = name
//
//    }
    
    @objc func editButtonTapped() {
        // Логика для нажатия на кнопку
        print("Custom button tapped!")
        
        editInfo()
        print(phoneNumber)
    }
    
    func toInteger(text: String) -> Int {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        initialsContainerView.layer.cornerRadius = initialsContainerView.frame.height / 2
        
        fullNameLabel.text = fullNameText
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
                    textField.text = String(self.phoneNumber ?? 0)// Подставляем номер контакта
                }

                // Добавляем кнопку "Save"
                let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                    // Получаем введенные данные
                    if let name = alertController.textFields?[0].text,
                       let surname = alertController.textFields?[1].text,
                       let phoneNumber = alertController.textFields?[2].text {
                        
                        // Обновляем данные контакта (например, в вашем массиве контактов или базе данных)
//                        self.selectedContact = (name, surname, phoneNumber)
                        
                        // Можете выполнить другие действия, например, сохранить контакт
                        print("Updated contact: \(name) \(surname), Phone: \(phoneNumber)")
                    }
                }

                // Добавляем кнопку "Cancel"
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                // Добавляем действия в UIAlertController
                alertController.addAction(saveAction)
                alertController.addAction(cancelAction)

                // Показываем alert
                present(alertController, animated: true, completion: nil)
            }
        }
    



