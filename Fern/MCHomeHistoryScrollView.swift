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
    
    
    
    override func layoutSubviews() {
        
        self.backgroundColor = UIColor.clear
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
    
    
    
    func addMoods(moods : [MCMood]){
        
        var viewy : Int = (Int) (self.frame.size.height / 4);
        
        for m : MCMood in moods{
            let moodView = MCMainPageHistoryItemViewController();
            moodView.moodName = m.moodName
            
            if(m.moodLocationName == nil){
                moodView.moodLocation = m.moodLocationName
            }
            
            
            moodView.view.frame = CGRect(x: 0, y: viewy, width: Int(self.frame.size.width), height: 60);
            self.addSubview(moodView.view);
            viewy += (60 + (Int)(self.frame.size.height / 6));
        }
        
        self.contentSize = CGSize(width: (Int)(self.frame.size.width), height: viewy);
      
        
        
        
    }

}
