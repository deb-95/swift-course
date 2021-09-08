//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

enum TextFieldType: Int {
    case email
    case password
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        executeLogin()
    }
    
    func executeLogin() {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authDataResult, error in
                guard let self = self else { return }
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch (textField.tag) {
        case TextFieldType.email.rawValue:
            passwordTextfield.becomeFirstResponder()
        case TextFieldType.password.rawValue:
            executeLogin()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
