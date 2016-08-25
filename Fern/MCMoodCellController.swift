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
    var firstInSection : Bool = false;
    var lastInSection : Bool = false;
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundView?.backgroundColor = UIColor.clear
        self.backgroundColor=UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        self.selectedBackgroundView = bgView
    }
    
    override func draw(_ rect: CGRect) {
        //Because I insist on pretty shit for no reason
        let drawingContext = UIGraphicsGetCurrentContext()
        
        drawingContext?.setLineWidth(0.75)
        drawingContext?.setStrokeColor(UIColor.white.cgColor)
        drawingContext?.setFillColor(UIColor.white.cgColor)
        if(firstInSection){
            drawingContext?.move(to:CGPoint(x: 30, y: self.frame.size.height/2))
            drawingContext?.addLine(to:CGPoint(x:30, y: self.frame.size.height))
            drawingContext?.strokePath()
        }else if(lastInSection){
            drawingContext?.move(to:CGPoint(x: 30, y: 0))
            drawingContext?.addLine(to:CGPoint(x:30, y: self.frame.size.height/2))
            drawingContext?.strokePath()

        }else{
            drawingContext?.move(to:CGPoint(x: 30, y: 0))
            drawingContext?.addLine(to:CGPoint(x:30, y: self.frame.size.height))
            drawingContext?.strokePath()
            
        }
      
        drawingContext?.fillEllipse(in: CGRect(x: 27.5, y: self.frame.size.height/2 - 2.5, width: 5, height: 5))
     
    }

}
