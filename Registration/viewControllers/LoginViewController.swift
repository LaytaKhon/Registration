//
//  LoginViewController.swift
//  Registration
//
//  Created by MIT App Dev on 12/1/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getsignUn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default)//closure
        { action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (authResult, error) in
                
                if let error = error {
                    self.showAlertDialog(inputMessage: error.localizedDescription)
                }
                
                guard let user = authResult?.user else { return }
                
                user.sendEmailVerification(completion: { (error) in
                    
                    if let error = error {
                        self.showAlertDialog(inputMessage: error.localizedDescription)
                    }
                    
                })
                
                
                
            })
        }
            
    }
    
    @IBAction func loginGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
     @IBAction func getSignIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (authResult, error) in
            
            if let error = error {
                self.showAlertDialog(inputMessage: error.localizedDescription)
            }
            
            guard let user = authResult?.user else { return }
            
            if !user.isEmailVerified {
                
                self.showAlertDialog(inputMessage: "Please verify your email.")
                
            } else {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! UINavigationController
                self.present(vc, animated: true, completion: nil)
                
            }
            
        }
     }
    
    @IBAction func loginFacebook(_ sender: Any) {
        facebookLogin()
    }
    func facebookLogin() {
        
        
        let login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: { result, error in
            if error != nil {
                print("Process error")
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    self.showAlertDialog(inputMessage: error.localizedDescription)
                    return
                }
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! UINavigationController
                self.present(vc, animated: true, completion: nil)
                
            }
            
        })
        
    }
}
