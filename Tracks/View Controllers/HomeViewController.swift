//
//  HomeViewController.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-09.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


// allows cells to have varying heights w/in the same table view, might not be needed but following makestagram
//extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let post = posts[indexPath.row]
//        
//        return post.imageHeight
//    }
//}
