//
//  MCMainPageHistoryItemViewController.swift
//  Fern
//
//  Created by Michael Coleman on 28/09/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit

class MCMainPageHistoryItemViewController: UIViewController {

    @IBOutlet var moodNameLabel : UILabel!
    @IBOutlet var moodTimeLabel : UILabel!
    @IBOutlet var moodLocationLabel : UILabel!
    @IBOutlet var buttonTest : UIButton!
    
    

    var mood : MCMood!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear;
        moodNameLabel.text = mood.moodName
        moodTimeLabel.text = NSDate().timeDifferenceToString(date: mood.moodTime) as String
        
        if(mood.moodLocationName == nil){
            moodLocationLabel.isHidden = true
        }else{
            moodLocationLabel.text = "At \(mood.moodLocationName!)"
        }
        buttonTest.isExclusiveTouch = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func thisthing(_ sender: AnyObject) {
        print("Working")
        let moodDict : [String : MCMood] = ["Mood":mood]
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "moodSelected"), object: nil, userInfo: moodDict)
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
