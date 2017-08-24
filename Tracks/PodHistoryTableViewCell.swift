//
//  PodHistoryTableViewCell.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-24.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import UIKit

class PodHistoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var podTrackedDateLabel: UILabel!
    
    @IBOutlet weak var podsTrackedValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.recordPodDataTextField.resignFirstResponder()
    }
    
}
