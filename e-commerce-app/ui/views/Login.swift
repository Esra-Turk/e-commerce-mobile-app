//
//  Login.swift
//  e-commerce-app
//
//  Created by Esra Türk on 17.10.2024.
//

import UIKit

class Login: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.white
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.cornerRadius = 5.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(named: "background-color")
        textField.layer.borderWidth = 0
    }
    
}
