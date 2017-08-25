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
   
    
    @IBAction func signInbutton(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: self)
    }

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        nameTextField.layer.borderColor = UIColor.white.cgColor
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.cornerRadius = 8.0
        
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 8.0
        
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 8.0
        
        createButton.layer.cornerRadius = 6
        
        // slide view up when keyboard appears
//        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @IBOutlet weak var nameTextField: UITextField!
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
        
        if (email == "" || name == "" || password == "") {
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
                        // handle error... Podlistservice.create(...)
                        return
                    }
                    
                    User.setCurrent(user, writeToUserDefaults: true)
                    
                    self.performSegue(withIdentifier: "toBuildProfileStoryboard", sender: self)
                    
//                    let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                    if let initialViewController = storyboard.instantiateInitialViewController() {
//                        self.view.window?.rootViewController = initialViewController
//                        self.view.window?.makeKeyAndVisible()
//                    }
                }
            }
            
        }
    }
    
    
    
    @IBOutlet weak var profilePictureFiller: UIImageView!
    @IBAction func pickProfilePicture(_ sender: AnyObject) {
        
        let image = UIImagePickerController()
        image.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePictureFiller.image = image
        } else {
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
    }
    
    
//    func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y != 0{
//                self.view.frame.origin.y += keyboardSize.height
//            }
//        }
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
