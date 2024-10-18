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
    @IBOutlet weak var loginButton: UIButton!
    
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.tintColor = UIColor(named: "button-orange")
        
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            self.showAlert(title: "Hata", message: "Email ve şifre giriniz.")
            return
        }
        
        viewModel.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.navigateToHomePage()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.showAlert(title: "Başarısız", message: "E-posta veya şifre yanlış")
                }
            }
        }
    }
    
    private func navigateToHomePage() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: false)
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let tabBarController = windowScene.windows.first?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 0  // Anasayfaya git
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
