//
//  SignUpViewController.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-02.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.layer.cornerRadius = 6
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        guard let password = passwordTextField.text,
            let email = emailTextField.text,
            let name = nameTextField.text
            else {
                return
        }
        
        if (email == "" && name == "" && password == "") {
            print ("Need at least you email")
            let emailController = UIAlertController(title: "Please insert an email and password", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel){(action) in ()}
            
            emailController.addAction(okAction)
            
            self.present(emailController, animated: true, completion: nil)
            
        } else {
            
            AuthService.createUser(controller: self, email: email, password: password) { (authUser) in
                guard let firUser = authUser else {
                    return
                }
                
                UserService.create(firUser, name: name, email: email) { (user) in
                    guard let user = user else {
                        // handle error
                        return
                    }
                    
                    User.setCurrent(user, writeToUserDefaults: true)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: .main)
                    if let initialViewController = storyboard.instantiateInitialViewController() {
                        self.view.window?.rootViewController = initialViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                }
            }
            
        }
    }
    
    @IBAction func pickProfilePicture(_ sender: Any) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
    }
    
}




// trying to get black border on bottom of textfields
//usernameTextField.setBottomBorder()
//passwordTextField.setBottomBorder()
//emailTextField.setBottomBorder()
//extension UITextField {
//    func setBottomBorder() {
//        self.borderStyle = .none
//        self.layer.backgroundColor = UIColor.white.cgColor
//        
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 0.0
//    }
//}
//
//        usernameTextField.layer.addSublayer(border)
//        usernameTextField.layer.masksToBounds = true
