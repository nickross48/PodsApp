//
//  PodHistory.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-24.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import UIKit

class PodHistory: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var podHistoryTableView: UITableView!
    
    var userPods = [PodEntry]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podHistoryCell", for: indexPath) as! PodHistoryTableViewCell        
        cell.podsTrackedValueLabel.text = String(userPods[indexPath.row].value)
        cell.podTrackedDateLabel.text = PodsService.dateToString(date: userPods[indexPath.row].creationDate!)
        
        
        
//        describing: userPods[indexPath.row].creationDate
        
//         = String(describing: userPods[indexPath.row].podName)
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        podHistoryTableView.reloadData()
        
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
