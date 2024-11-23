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
    }


}

