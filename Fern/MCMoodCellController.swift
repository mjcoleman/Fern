//
//  MCMoodCellController.swift
//  Fern
//
//  Created by Michael Coleman on 27/07/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit

class MCMoodCellController: UITableViewCell {

    @IBOutlet weak var moodDate: UILabel!
    @IBOutlet weak var moodName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
