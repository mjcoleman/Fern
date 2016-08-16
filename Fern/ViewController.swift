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

//Custom Classes

class MCMoodInputView : UIView{
    @IBOutlet var moodNameField : UITextField!
    override func draw(_ rect: CGRect) {
        let drawingContext = UIGraphicsGetCurrentContext()
        drawingContext?.setLineWidth(1)
        drawingContext?.setStrokeColor(UIColor.white.cgColor)
        drawingContext?.move(to: CGPoint(x: self.moodNameField.frame.origin.x, y: self.moodNameField.frame.origin.y + self.moodNameField.frame.size.height + 3))
        drawingContext?.addLine(to: CGPoint(x: self.moodNameField.frame.origin.x + self.moodNameField.frame.size.width, y: self.moodNameField.frame.origin.y + self.moodNameField.frame.size.height + 3))
        drawingContext?.strokePath()
    }
}


class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    var locationOn : Bool = true
    var locationManager = CLLocationManager()
    var lastMood : MCMood?
    let moodManager : MCMoodStoreManager = MCMoodStoreManager.sharedInstance
    let watchManager : MCWatchSessionManager = MCWatchSessionManager.sharedInstance
    let appDel : AppDelegate = UIApplication.shared.delegate! as! AppDelegate

        
    @IBOutlet weak var lastMoodLabel: UIButton!
    @IBOutlet weak var locationToggle: UISwitch!
    @IBOutlet weak var moodNoteField: UITextView!
    @IBOutlet weak var moodNameField: UITextField!
    @IBOutlet var moodTimeDiffLabel : UILabel!
    @IBOutlet var fernWelcomeText : UILabel!
    @IBOutlet var moodEntryView : UIVisualEffectView!
   
    
    @IBOutlet var moodInputView : MCMoodInputView!
    @IBOutlet var notesView : UIView!
    
    //Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self;
        //moodNameField.delegate = self;
        //moodNoteField.delegate = self;
        
        //Move to "first run" function.
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }
        
        
        self.setupInterface()
        
        
        //Notification center stuff
        //NotificationCenter.default.addObserver(self, selector: #selector(self.setupInterface), name: "updateUI" as NSNotification.Name, object: nil)
        
        
        notesView.frame = CGRect(x: self.view.frame.width + 20, y: notesView.frame.origin.y, width: notesView.frame.size.width, height: notesView.frame.size.height);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mooddetails" {
            let moodDetailsVC = segue.destination as! MoodDetailsViewController
            moodDetailsVC.moodData = lastMood
        }
    }
    
    
    
    
    //Functions
    func setupInterface(){
        
       // self.moodNameField.text = ""
       // self.moodNoteField.text = ""
        
        //Get last Mood from MoodManager
        lastMood = moodManager.getLastMood()
        if lastMood?.moodName == ""{
            //No last mood. HANDLE THIS
            
        }else{
            //lastMoodLabel.setTitle(lastMood?.moodName, for: UIControlState.normal)
           //moodTimeDiffLabel.text = NSDate().timeDifferenceToString(date: (lastMood?.moodDate)!) as String + " you were feeling"
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
    
    
    func firstRunSetup(){
        
    }
    
   // pragma mark IBActions

    @IBAction func LocationToggle(_ sender: AnyObject) {
        if locationOn{
            locationOn = false;
        }else{
            locationOn = true;
        }
        
    }

    @IBAction func AddMood(_ sender: AnyObject) {
        let currentLocation : CLLocation = locationManager.location!
        
        let newMood : MCMood = MCMood(name: moodNameField.text! as NSString, notes: moodNoteField.text as NSString?, lat:currentLocation.coordinate.latitude , lon: currentLocation.coordinate.longitude, date: NSDate())
        let success : Bool = moodManager.addMoodToStore(mood: newMood)
       
        if !success{
            print("Couldn't add mood")
            
        }
        self.setupInterface()
    
    }
    
    @IBAction func AddNotes(_ sender: AnyObject){
        UIView.animate(withDuration: 0.5, animations: {
            self.notesView.frame = CGRect(x: 0, y: self.notesView.frame.origin.y, width: self.notesView.frame.size.width, height: self.notesView.frame.size.height);
            self.moodInputView.frame = CGRect(x: 0 - self.moodInputView.frame.size.width, y: self.moodInputView.frame.origin.y, width: self.moodInputView.frame.size.width, height: self.moodInputView.frame.size.height);
            
        })
    }
    
    @IBAction func CancelNotes(_ sender: AnyObject){
        UIView.animate(withDuration: 0.5, animations: {
            self.moodInputView.frame = CGRect(x: 0, y: self.moodInputView.frame.origin.y, width: self.moodInputView.frame.size.width, height: self.moodInputView.frame.size.height);
            self.notesView.frame = CGRect(x: self.view.frame.width + 20, y: self.notesView.frame.origin.y, width: self.notesView.frame.size.width, height: self.notesView.frame.size.height);
            
        })
    }
}
