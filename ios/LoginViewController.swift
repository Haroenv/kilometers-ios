//
//  LoginiewController.swift
//
//  Created by Haroen Viaene on 02/05/16.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginEmail.delegate = self
        loginPassword.delegate = self
        registerEmail.delegate = self
        registerPassword.delegate = self
        
        loginEmail.tag = 100
        loginPassword.tag = 101
        registerEmail.tag = 102
        registerPassword.tag = 103
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (textField.tag == loginEmail.tag) {
            print("go to password field")
        } else if (textField.tag == loginPassword.tag) {
            print("login with password")
        } else if (textField.tag == registerEmail.tag) {
            print("go to password field")
        } else if (textField.tag == registerPassword.tag) {
            print("create account")
            
        }
        return true
    }
    
}