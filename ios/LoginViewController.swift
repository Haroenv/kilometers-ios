//
//  LoginiewController.swift
//
//  Created by Haroen Viaene on 02/05/16.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("we are in the login screen")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}