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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        messageStackView.layer.cornerRadius = 5
        callStackView.layer.cornerRadius = 5
        videoStackView.layer.cornerRadius = 5
        mailStackView.layer.cornerRadius = 5
        phoneStackView.layer.cornerRadius = 5
        undoDeleteButton.layer.cornerRadius = 5
        deleteContactButton.layer.cornerRadius = 5
        
    }
    
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
    
    
    @IBAction func editActionPressed(_ sender: Any) {
    }
    

}

