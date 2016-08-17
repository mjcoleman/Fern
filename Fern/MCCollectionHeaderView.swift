//
//  MCCollectionHeaderView.swift
//  Fern
//
//  Created by Michael Coleman on 17/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit

class MCCollectionHeaderView: UICollectionReusableView {
    @IBOutlet var headerLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        // Initialization code
    }
    
}
