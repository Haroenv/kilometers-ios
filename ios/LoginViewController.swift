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
        root.observeAuthEventWithBlock({ authData in
            if authData != nil {
                print("authdata: \(authData.uid)")
                let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainView")
                self.presentViewController(homeViewController!, animated: true, completion: nil)
            } else {
                print("not logged in")
            }
        })
    }
    
    func shake(textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - 8, textField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + 8, textField.center.y))
        textField.layer.addAnimation(animation, forKey: "position")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (textField.tag == loginEmail.tag) {
            loginPassword.becomeFirstResponder()
        } else if (textField.tag == loginPassword.tag) {
            root.authUser(loginEmail.text, password: loginPassword.text, withCompletionBlock: { error, authData in
                if error != nil {
                    self.shake(textField)
                } else {
                    print("Successfully logged in with uid: \(authData.uid)")
                }
            })
        } else if (textField.tag == registerEmail.tag) {
            registerPassword.becomeFirstResponder()
        } else if (textField.tag == registerPassword.tag) {
            root.createUser(registerEmail.text, password: registerPassword.text, withValueCompletionBlock: { error, result in
                if error != nil {
                     self.shake(textField)
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                }
            })
            
        }
        return true
    }
    
}