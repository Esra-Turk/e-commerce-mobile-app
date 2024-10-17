//
//  Register.swift
//  e-commerce-app
//
//  Created by Esra Türk on 17.10.2024.
//

import UIKit

class Register: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verificationPasswordField: UITextField!
    
    private var viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        verificationPasswordField.delegate = self
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard passwordTextField.text == verificationPasswordField.text else {
            print("Şifreler eşleşmiyor")
            return
        }
        
        viewModel.register(email: emailTextField.text!, password: passwordTextField.text!) { result in
            switch result {
            case .success(_):
                print("Kayıt başarılı")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
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
