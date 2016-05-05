//
//  LoginiewController.swift
//
//  Created by Haroen Viaene on 02/05/16.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let root = Firebase(url: "https://kilometers.firebaseio.com")
    
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
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(UIApplicationDelegate.applicationDidBecomeActive(_:)),
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
    }
    
    func applicationDidBecomeActive(notification: NSNotification) {
        print("back active")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (textField.tag == loginEmail.tag) {
            loginPassword.becomeFirstResponder()
        } else if (textField.tag == loginPassword.tag) {
            print("login with password")
        } else if (textField.tag == registerEmail.tag) {
            registerPassword.becomeFirstResponder()
        } else if (textField.tag == registerPassword.tag) {
            root.createUser(registerEmail.text, password: registerPassword.text, withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                    print("not logged in :(")
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                }
            })
            
        }
        return true
    }
    
}