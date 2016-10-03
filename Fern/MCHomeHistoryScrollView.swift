//
//  MCHomeHistoryScrollView.swift
//  Fern
//
//  Created by Michael Coleman on 28/09/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit

class MCHomeHistoryScrollView: UIScrollView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    var historyContentSize : CGSize!
    var currentMoodCount : Int = 0
    var moodViews : [MCMainPageHistoryItemViewController]! = []
    
    
    override func layoutSubviews() {
        self.delaysContentTouches = false;
        self.canCancelContentTouches = true;
        self.backgroundColor = UIColor.clear
        self.isExclusiveTouch = false;
    }
    override func draw(_ rect: CGRect) {
        //Clear Background
        
        
        //Centre Line
        let drawingContext = UIGraphicsGetCurrentContext()
        drawingContext?.setLineWidth(0.75)
        drawingContext?.setStrokeColor(UIColor.white.cgColor)
        drawingContext?.setFillColor(UIColor.white.cgColor)
        drawingContext?.move(to:CGPoint(x: self.frame.size.width / 2, y: 0))
        drawingContext?.addLine(to:CGPoint(x:self.frame.size.width / 2, y: self.frame.size.height))
        drawingContext?.strokePath()
        

        
    }

    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if(view is UIButton){
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
  

}
