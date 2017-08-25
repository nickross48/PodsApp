//
//  BuildProfileViewController.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-07.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import UIKit

class BuildProfileViewController: UIViewController {
    
    @IBOutlet weak var customPod1: UITextField!
    @IBOutlet weak var customPod2: UITextField!
    @IBOutlet weak var customPod3: UITextField!
    @IBOutlet weak var customPod4: UITextField!
    @IBOutlet weak var customPod5: UITextField!
    
    @IBOutlet weak var toHomeButton: UIButton!
    @IBAction func toHomeButtonPressed(_ sender: Any) {
        guard let podName1 = customPod1.text,
            let podName2 = customPod2.text,
            let podName3 = customPod3.text,
            let podName4 = customPod4.text,
            let podName5 = customPod5.text
            else {
                return
        }
        
        if (podName1 == "" && podName2 == "" && podName3 == "" && podName4 == "" && podName5 == "") {
            print ("We need to track at least one pod")
            let emailController = UIAlertController(title: "We need to track at least one pod", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel){(action) in ()}
            
            emailController.addAction(okAction)
            
            self.present(emailController, animated: true, completion: nil)
            
        } else {
            // create pod and tie to currentUser
            
            if customPod1.text! != "" {
                PodsService.create(podName: customPod1.text!, completion: {_ in})
            } else {
                print("This field is blank")
            }
            
            if customPod2.text! != "" {
                PodsService.create(podName: customPod2.text!, completion: {_ in})
            } else {
                print("This field is blank")
            }
            if customPod3.text! != "" {
                PodsService.create(podName: customPod3.text!, completion: {_ in})
            } else {
                print("This field is blank")
            }

            if customPod4.text! != "" {
                PodsService.create(podName: customPod4.text!, completion: {_ in})
            } else {
                print("This field is blank")
            }
            
            if customPod5.text! != "" {
                PodsService.create(podName: customPod5.text!, completion: {_ in})
            } else {
                print("This field is blank")
            }

            performSegue(withIdentifier: "toMain", sender: self)
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.customPod1.resignFirstResponder()
        self.customPod2.resignFirstResponder()
        self.customPod3.resignFirstResponder()
        self.customPod4.resignFirstResponder()
        self.customPod5.resignFirstResponder()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
