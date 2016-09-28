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
    @IBOutlet weak var moodLat: UILabel!
    @IBOutlet weak var moodLon: UILabel!
    @IBOutlet weak var moodNotes: UITextView!
    @IBOutlet weak var moodMap: MKMapView!
    @IBOutlet var moodCountLabel : UIButton!
    
   //Object will be passed from ViewController
    var moodData : MCMood?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(moodData?.moodLocation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: (moodData?.moodLocation)!, span: span)
        moodMap.setRegion(region, animated: false)
        moodName.text = moodData?.moodName
        moodNotes.text = moodData?.moodNotes
        moodDate.text = moodData?.moodDate?.dateToString(hourmin: true, dayofweek: true, daymonth: true, year: true)
        moodCountLabel.setTitle(("YOU'VE BEEN " + (moodData?.moodName.uppercased())! + " \(MCMoodStoreManager.sharedInstance.getCountForMoodName(name: (moodData?.moodName)!)) TIMES"), for:UIControlState.normal)
        
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func showAllMoods(_ sender: AnyObject){
        let historyView = storyboard?.instantiateViewController(withIdentifier: "historyview") as! MCHistoryViewController
        historyView.setupView(categoryType: Constants.HISTORY_CATEGORY_TYPE.HISTORY_MOOD_NAME, arguments: (moodData?.moodName, nil, nil, nil, nil))
        self.present(historyView, animated: true, completion: nil)
    }
}
