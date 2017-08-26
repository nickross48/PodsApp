//
//  HomeViewController.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-09.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//
import Foundation
import Firebase
import FirebaseAuthUI
import FirebaseDatabase
import UIKit


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // need to pull the list of pods tied to the user
    var userPods = [Pods]() {
        didSet {
            homeTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPods.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordPodsCell", for: indexPath) as! RecordPodsTableViewCell
        cell.podNameLabel.text = userPods[indexPath.row].podName
        return cell
    }

//        RecordPodsTableViewCell.podNameLabel.text = "TestPod"

        
//            UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "currentDateCell")
//        cell.?.text = list[indexPath.row]
    
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
//  ADD PODS to Firebase code here
    @IBOutlet weak var addPodsButton: UIBarButtonItem!
    @IBAction func addPodsButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Name of Pod", message: "What would you like to track?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let userInput = alertController.textFields![0].text
            if (userInput!.isEmpty) {
                return
            } else {
                    //Import to firebase here
                if userInput! != "" {
                    PodsService.create(podName: userInput!, completion: {_ in})
                } else {
                    print("This field is blank")
                }
                PodsService.retrievePods(userID: User.current.uid, completion: { (pods) in
                    if let arrayOfPods = pods {
                        self.userPods = arrayOfPods }
                    else {
                        print ("error")
                    }
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
//  LOGOUT code here
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBAction func logoutButtonClicked(_ sender: Any) {
        presentLogOut(viewContoller: self)
    }
    
    func logUserOut() {
        do{
            try Auth.auth().signOut()
        } catch let error as NSError {
            assertionFailure("Error: error signing in \(error.localizedDescription)")
        }
    }
    
    func presentLogOut(viewContoller: UIViewController) {
        let logOutAlert = UIAlertController(title: "Logout", message: "Confirm Pods logout", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Log out", style: .default, handler: { _ in
            self.logUserOut()
        })
        
        let cancelAction2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        logOutAlert.addAction(cancelAction)
        logOutAlert.addAction(cancelAction2)
        
        self.present(logOutAlert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var recordDataButton: UIButton!
    @IBAction func recordDataButtonClicked(_ sender: Any) {
        
        
        for i in 0..<homeTableView.numberOfRows(inSection: 0) {
            guard let cell = self.homeTableView.cellForRow(at: IndexPath.init(row: i, section: 0)) as! RecordPodsTableViewCell?,
                let textValue = cell.recordPodDataTextField.text,
                let value = Double(textValue)
                else {return}
            
            
            let podEntry = CoreDataHelper.newPodEntry()
            podEntry.creationDate = NSDate.init()
//            podEntry.creationDate = Date() as NSDate
            podEntry.podName = cell.podNameLabel.text
            podEntry.value = value
            
            CoreDataHelper.savePodEntry()
            
        }
        
    }

    func configureTableView() {
        // remove separators for empty cells
        homeTableView.tableFooterView = UIView()
        // remove separators from cells
        homeTableView.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: currDate)
        dateLabel.text! = dateString
        
        recordDataButton.layer.cornerRadius = 6
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        PodsService.retrievePods(userID: User.current.uid, completion: { (pods) in
            if let arrayOfPods = pods {
                self.userPods = arrayOfPods }
            else {
                print ("error")
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func authListener(viewController view: UIViewController) -> AuthStateDidChangeListenerHandle{
        let authHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            guard user == nil
                else {return}
            let storyboard = UIStoryboard(name: "LogInStoryBoard", bundle: .main)
            guard let controller = storyboard.instantiateInitialViewController() else {
                fatalError()
            }
            view.view.window?.rootViewController = controller
            view.view.window?.makeKeyAndVisible()
            // So in culmination with the loguserout function what this essentially does is that it lets us return to the log in storyboard when the user logs out but what is actually signing the user out of firebase is the log user out function
        }
        return authHandle
    }
    func removeAuthListener (authHandle: AuthStateDidChangeListenerHandle?)
    {
        if let authHandle = authHandle{
            
            Auth.auth().removeStateDidChangeListener(authHandle)
            
        }
        // So as we know what is happening is that what a handler does is that creates and returns an action with the specified behavior so what this does is almost like a setting function because what we are essentially doing is that we are changing the code within firebase to say change the listener block to a block that essentailly tells us that the user has signed out
    }
    
    
    
    
}



//            podEntry.creationDate = dateLabel.text!


// used to be under tableview cell for row at
//         cell.currentDateLabel.text = "note's title"



// allows cells to have varying heights w/in the same table view, might not be needed but following makestagram
//extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let post = posts[indexPath.row]
//        
//        return post.imageHeight
//    }
//}
