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
    
    
    var moodName : String!
    var moodTime : String!
    var moodLocation : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear;
        moodNameLabel.text = moodName
        if(moodLocation == nil){
            moodLocationLabel.isHidden = true
        }else{
            moodLocationLabel.text = moodLocation!
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI(){
        
        
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
