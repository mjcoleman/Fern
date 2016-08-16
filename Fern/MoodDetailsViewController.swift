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
    @IBOutlet weak var moodNotes: UILabel!
    @IBOutlet weak var moodMap: MKMapView!
    @IBOutlet var moodCountLabel : UILabel!
    
   //Object will be passed from ViewController
    var moodData : MCMood?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: (moodData?.moodLocation)!, span: span)
            moodMap.setRegion(region, animated: false)

        
        
        
        
        
        moodName.text = moodData?.moodName
       // moodNotes.text = moodData?.moodNotes
        moodDate.text = moodData?.moodDate?.dateToString(hourmin: true, dayofweek: true, daymonth: true, year: true)
        moodCountLabel.text = "YOU'VE BEEN " + (moodData?.moodName.uppercased())! + " 8 TIMES"
        
        
        
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
