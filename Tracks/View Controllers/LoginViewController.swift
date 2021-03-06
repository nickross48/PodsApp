//
//  LoginViewController.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-03.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseAuthUI

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func toSignUpUnwind(segue: UIStoryboardSegue) {}
    
    @IBAction func toSignUpVC(_ sender: Any) {
        performSegue(withIdentifier: "segueToSignUp", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.layer.borderColor = UIColor.white.cgColor
        emailField.layer.borderWidth = 1.0
        emailField.layer.cornerRadius = 8.0
        
        passwordField.layer.borderColor = UIColor.white.cgColor
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.cornerRadius = 8.0
        
        signInButton.layer.cornerRadius = 6
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if let _ = Auth.auth().currentUser {
//            //self.signIn()
//        }
    }
    
    @IBAction func didTapSignIn(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        
        if (email == "" && password == "") {
            print ("Need at least you email")
            let emailController = UIAlertController(title: "Please insert an email and password", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel){(action) in ()}
            
            emailController.addAction(okAction)
            
            self.present(emailController, animated: true, completion: nil)
            
        } else {
            Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    print("User is just signed in and their user defaults have not been set yet")
                    UserService.show(forUID: (user?.uid)!, completion: { (user) in
                        if let user = user {
                            User.setCurrent(user, writeToUserDefaults: true)
                            self.finishLoggingIn()
                            print("User defaults has now been set")
                            return
                        }
                        else {
                            print("Error: User does not exist")
                            return
                        }
                    })
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
            })
        }
    }
                
    func finishLoggingIn() {
        print("User is done logging in from the log in view controller")
    }
    
    @IBAction func didRequestPasswordReset(_ sender: UIButton) {
        let prompt = UIAlertController(title: "Reset password", message: "Email:", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            Auth.auth().sendPasswordReset(withEmail: userInput!, completion: { (error) in
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .userNotFound:
                            DispatchQueue.main.async {
                                self.showAlert("User account not found. Try registering")
                            }
                        default:
                            DispatchQueue.main.async {
                                self.showAlert("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.showAlert("You'll receive an email shortly to reset your password.")
                    }
                }
            })
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "BoxScan", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwordField.resignFirstResponder()
        self.emailField.resignFirstResponder()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


// Previous code for didTapSignIn.Else.Auth.auth.signIn
//              if let _ = user {
//                    self.signIn()
//                    print("User signed in")
//
//                    self.performSegue(withIdentifier: "toMainStoryboard", sender: self)
//
//
//                }
//                else {
//                    if let error = error {
//                        if let errCode = AuthErrorCode(rawValue: error._code) {
//                            switch errCode {
//                            case .userNotFound:
//                                self.showAlert("User account not found. Try registering")
//                            case .wrongPassword:
//                                self.showAlert("Incorrect username/password combination")
//                            default:
//                                self.showAlert("Error: \(error.localizedDescription)")
//                            }
//                        }
//
//                        let signInErrorController = UIAlertController(title: "User does not exist", message: nil, preferredStyle: .alert)
//                        let okAction = UIAlertAction(title: "Ok", style: .cancel){(action) in ()}
//                        signInErrorController.addAction(okAction)
//                        self.present(signInErrorController, animated: true, completion: nil)
//
//                        return
//                    }
//                    assertionFailure("user and error are nil")
//                    return
//                }

// Don't know what this code is
//               func signIn() {
//                  let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                  if let initialViewController = storyboard.instantiateInitialViewController() {
//                      self.view.window?.rootViewController = initialViewController
//                      self.view.window?.makeKeyAndVisible()
//                  }
//              }

