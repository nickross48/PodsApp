//
//  HomeViewController.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-09.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

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
    
    @IBOutlet weak var addPodsButton: UIBarButtonItem!
    @IBAction func addPodsButtonClicked(_ sender: Any) {

    }
    
    @IBOutlet weak var profileButton: UIBarButtonItem!
    @IBAction func profileButtonClicked(_ sender: Any) {
        
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
        dateFormatter.dateFormat = "dd.MM.YY"
        let dateString = dateFormatter.string(from: currDate)
        dateLabel.text! = dateString
        
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
