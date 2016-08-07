//
//  ViewController.swift
//  Fern
//
//  Created by Michael Coleman on 26/07/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    var locationOn : Bool = true
    var locationManager = CLLocationManager()
    var lastMood : MCMood?
    let moodManager : MCMoodStoreManager = MCMoodStoreManager.sharedInstance
    let watchManager : MCWatchSessionManager = MCWatchSessionManager.sharedInstance
    let appDel : AppDelegate = UIApplication.shared().delegate! as! AppDelegate

        
    @IBOutlet weak var lastMoodLabel: UIButton!
    @IBOutlet weak var locationToggle: UISwitch!
    @IBOutlet weak var moodNoteField: UITextView!
    @IBOutlet weak var moodNameField: UITextField!
    @IBOutlet var moodTimeDiffLabel : UILabel!
    @IBOutlet var fernWelcomeText : UILabel!
    @IBOutlet var moodEntryView : UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self;
        moodNameField.delegate = self;
        moodNoteField.delegate = self;
        
        //Move to "first run" function.
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }
        
        
        self.setupInterface()
        
        
        //Notification center stuff
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupInterface), name: "updateUI" as NSNotification.Name, object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mooddetails" {
            let moodDetailsVC = segue.destinationViewController as! MoodDetailsViewController
            moodDetailsVC.moodData = lastMood
        }
    }
    
    
    func setupInterface(){
        
        self.moodNameField.text = ""
        self.moodNoteField.text = ""
        
        //Get last Mood from MoodManager
        lastMood = moodManager.getLastMood()
        if lastMood?.moodName == ""{
            //No last mood. HANDLE THIS
            
        }else{
            lastMoodLabel.setTitle(lastMood?.moodName, for: UIControlState.normal)
            moodTimeDiffLabel.text = NSDate().timeDifferenceToString(date: (lastMood?.moodDate)!) as String + " you were feeling"
        }
        
        
        
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
           // locationToggle.isEnabled = true
            locationManager.startUpdatingLocation()
            break;
        case .authorizedWhenInUse:
          //  locationToggle.isEnabled = false
            break;
        case .restricted:
          //  locationToggle.isEnabled = false
            break;
        case .denied:
          //  locationToggle.isEnabled = false
            break
        default:
            break
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }

    @IBAction func LocationToggle(_ sender: AnyObject) {
        if locationOn{
            locationOn = false;
        }else{
            locationOn = true;
        }
        
    }

    @IBAction func AddMood(_ sender: AnyObject) {
        var currentLocation : CLLocation = locationManager.location!
        
        let newMood : MCMood = MCMood(name: moodNameField.text!, notes: moodNoteField.text, lat:currentLocation.coordinate.latitude , lon: currentLocation.coordinate.longitude, date: NSDate())
        let success : Bool = moodManager.addMoodToStore(mood: newMood)
       
        if !success{
            print("Couldn't add mood")
            
        }
        self.setupInterface()
    
    }
    
    @IBAction func AddNotes(_ sender: AnyObject){
        UIView.animate(withDuration: 0.5, animations: {()-> Void in
           // self.fernWelcomeText.frame = CGRect(x:self.fernWelcomeText.frame.origin.x, y:20, width:self.fernWelcomeText.frame.size.width, height:self.fernWelcomeText.frame.size.height)
            self.moodEntryView.frame = CGRect(x:self.moodEntryView.frame.origin.x, y:20, width:self.moodEntryView.frame.size.width, height:self.moodEntryView.frame.size.height)
           // self.fernWelcomeText.frame = CGRect(x:self.fernWelcomeText.frame.origin.x, y:20, width:self.fernWelcomeText.frame.size.width, height:self.fernWelcomeText.frame.size.height)
            
        })
        
    }
}
