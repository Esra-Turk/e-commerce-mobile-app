//
//  Register.swift
//  e-commerce-app
//
//  Created by Esra Türk on 17.10.2024.
//

import UIKit
import FirebaseFirestore

class Register: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verificationPasswordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    private var viewModel = RegisterViewModel()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        verificationPasswordField.delegate = self
        registerButton.tintColor = UIColor(named: "button-orange")
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard passwordTextField.text == verificationPasswordField.text else {
            print("Şifreler eşleşmiyor")
            self.showAlert(title: "Başarısız", message: "Şifreler aynı değil")
            return
        }
        
        viewModel.register(email: emailTextField.text!, password: passwordTextField.text!) { result in
            switch result {
            case .success(let user):
                self.viewModel.saveUserDetails(userId: user.uid, fullName: self.userNameTextField.text ?? "", email: self.emailTextField.text!) { error in
                        if let error = error {
                            print("Kullanıcı bilgileri kaydedilemedi: \(error.localizedDescription)")
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
            case .failure(let failure):
                print(failure.localizedDescription)
                self.showAlert(title: "Başarısız", message: "Bu email adresi kullanılıyor")
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
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
