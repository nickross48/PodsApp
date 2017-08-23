//
//  HistoryViewController.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-15.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import UIKit


class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    
    
    // need to pull the list of pods tied to the user
    var userPods = [Pods]() {
        didSet {
            historyTableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "showPodsCell", for: indexPath) as! HistoryPodsTableViewCell
        cell.visualizedPodNameLabel.text = userPods[indexPath.row].podName
        return cell
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
