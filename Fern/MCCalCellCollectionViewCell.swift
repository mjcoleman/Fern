//
//  MCCalCellCollectionViewCell.swift
//  Fern
//
//  Created by Michael Coleman on 15/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit

class MCCalCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var moodCountLabel : UILabel!
    @IBOutlet var dateLabel : UILabel!
    
    var isSpacer : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor=UIColor.clear
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        if(!isSpacer){
            let drawingContext = UIGraphicsGetCurrentContext()
            drawingContext?.setLineWidth(0.25)
            drawingContext?.setStrokeColor(UIColor.white.cgColor)
            drawingContext?.stroke(CGRect(x: 1, y: 1, width: self.frame.size.width-1, height: self.frame.size.height-1))
            self.moodCountLabel.text = String(arc4random_uniform(7))
        }else{
            self.dateLabel.text = ""
            self.moodCountLabel.text=""
        }
           }

}
