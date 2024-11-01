//
//  LoginViewController.swift
//  DOMJudge
//
//  Created by Jan Drobílek on 1/11/24.
//


import UIKit

class LoginViewController: UIViewController {
    
    let loginManager = DOMJudgeLoginManager()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else { return }
        
        loginManager.login(username: username, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    print("Login successful. Token: \(token)")
                    // Transition to the main screen or home view
                case .failure(let error):
                    self.errorLabel.text = "Login failed: \(error.localizedDescription)"
                    print("Login failed: \(error.localizedDescription)")
                }
            }
        }
    }
}