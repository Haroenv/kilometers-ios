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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}