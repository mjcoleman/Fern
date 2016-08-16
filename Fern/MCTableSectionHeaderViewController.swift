//
//  MCTableSectionHeaderViewController.swift
//  Fern
//
//  Created by Michael Coleman on 15/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit

class MCTableSectionHeaderViewController: UITableViewHeaderFooterView {
    @IBOutlet var sectionLabel : UILabel!
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        
        let drawingContext = UIGraphicsGetCurrentContext()
        drawingContext?.setLineWidth(0.75)
        drawingContext?.setStrokeColor(UIColor.white.cgColor)
        drawingContext?.move(to: CGPoint(x: 5, y: self.frame.size.height/2))
        drawingContext?.addLine(to: CGPoint(x: self.sectionLabel.frame.origin.x - 5, y: self.frame.size.height/2))
        drawingContext?.strokePath()
        drawingContext?.move(to: CGPoint(x: self.sectionLabel.frame.origin.x + self.sectionLabel.frame.width + 5, y: self.frame.size.height/2))
        drawingContext?.addLine(to:CGPoint(x: self.frame.origin.x + self.frame.size.width - 5, y: self.frame.size.height/2))
        drawingContext?.strokePath()
        
        
        
    }


    
}
