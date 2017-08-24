//
//  RecordPodsTableViewCell.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-18.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import UIKit

class RecordPodsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var podNameLabel: UILabel!
    
    @IBOutlet weak var recordPodDataTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.recordPodDataTextField.resignFirstResponder()
    }
    
}
