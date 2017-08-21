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
    var userPods = [Pods]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return userPods.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordPodsDateCell", for: indexPath) as! RecordPodsTableViewCell
        cell.podNameLabel.text = "Test label"
        return cell
    }

        //        RecordPodsTableViewCell.podNameLabel.text = "TestPod"

        
//            UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "currentDateCell")
//        cell.?.text = list[indexPath.row]
    
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY"
        let dateString = dateFormatter.string(from: currDate)
        dateLabel.text! = dateString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



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
