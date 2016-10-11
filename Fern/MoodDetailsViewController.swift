//
//  MoodDetailsViewController.swift
//  Fern
//
//  Created by Michael Coleman on 26/07/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class MoodDetailsViewController: UIViewController {

    @IBOutlet weak var moodName: UILabel!
    @IBOutlet weak var moodDate: UILabel!
    @IBOutlet var stackView : UIStackView!
    @IBOutlet var notesTextView : UITextView!
    
    
   //Object will be passed from ViewController
    var moodData : MCMood?
    
    //Scroll View & Contents
    @IBOutlet var scrollView : UIScrollView!
    var contentView : MCDetailsInfoViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  moodName.text = moodData?.moodName
       // moodDate.text = moodData?.moodTime.dateToString(hourmin: true, dayofweek: true, daymonth: true, year: true)
        
      //  notesTextView.text = moodData?.moodNotes
        
        
        
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
}
