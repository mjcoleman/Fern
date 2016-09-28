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


class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate{
    
    var locationOn : Bool = true
    var locationManager = MCLocationManager.init()
    var lastMood : MCMood?
    let moodManager : MCMoodStoreManager = MCMoodStoreManager.sharedInstance
    let watchManager : MCWatchSessionManager = MCWatchSessionManager.sharedInstance
    let appDel : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
    var originalContentOffset : CGPoint = CGPoint(x:0,y:0)
    var currentMood : NSManagedObject?
    
    @IBOutlet var moodNameField : UITextField!
    @IBOutlet var moodInputStatusField : UILabel!
    @IBOutlet var addNotesButton : UIButton!
    @IBOutlet var showHistoryButton : UIButton!
    @IBOutlet var newMoodButton : UIButton!
    @IBOutlet var scrollingMoodView : UIScrollView!
    @IBOutlet var notesView : UIView!
    @IBOutlet var moodNotesField : UITextView!
    
    
    @IBOutlet var historyScrollView : MCHomeHistoryScrollView!
    

    //Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Move to "first run" function.
        self.locationOn = locationManager.locationEnabled
        
        self.setupInterface()
        
        
        //Notification center stuff
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupInterface), name:NSNotification.Name(rawValue: "updateUI"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupInterface), name:NSNotification.Name(rawValue: "backgrounded"), object: nil)

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.setupInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        let startY : Int = Int(newMoodButton.frame.origin.y + newMoodButton.frame.size.height)
        let endY : Int = Int(showHistoryButton.frame.origin.y) - startY
        
        //Maybe this will fix autolayouts bullshit
        historyScrollView.frame = CGRect(x: 0, y: startY, width:Int(self.view.frame.size.width), height:endY)
        
        self.view.endEditing(false)
        
        //Get last 5 moods from mood manager
        historyScrollView.addMoods(moods:moodManager.getMoodsFromStore(number: 5))
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mooddetails" {
            let moodDetailsVC = segue.destination as! MoodDetailsViewController
            moodDetailsVC.moodData = lastMood
        }else if segue.identifier == "moodhistory"{
            let moodHistoryVC = segue.destination as! MCHistoryViewController
          
            
            moodHistoryVC.setupView(categoryType: Constants.HISTORY_CATEGORY_TYPE.HISTORY_MOOD_ALL, arguments: nil)
        }
    }
    
    
    //Functions
    func setupInterface(){

        
      
        
        
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(moodNameField.text == ""){
            moodNameField.text = "HOW ARE YOU FEELING RIGHT NOW?"
            moodInputStatusField.isHidden = true
            addNotesButton.isHidden = true
        }else{
            addNotesButton.isHidden = false
        }
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moodInputStatusField.isHidden = false
        moodNameField.font = UIFont(name: (moodNameField.font?.fontName)!, size: 50)
        addNotesButton.isHidden = false
        UIView.animate(withDuration: 0.5, animations:{()->Void in
           self.moodNameField.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)

            })
        
        
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
    
    
    @IBAction func NewMood(_ sender: AnyObject){
        UIView.animate(withDuration:1, animations: {
            self.historyScrollView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.historyScrollView.frame.size.width, height: self.historyScrollView.frame.size.height)
            self.historyScrollView.alpha = 0.0
            self.newMoodButton.frame = CGRect(x: self.newMoodButton.frame.origin.x, y: self.newMoodButton.frame.origin.y + 80, width: self.newMoodButton.frame.size.width, height: self.newMoodButton.frame.size.height)
            
        })
        let moodEntry = MCMoodEntryViewController()
        self.view.addSubview(moodEntry.view)
        
    }
    
    
    @IBAction func SaveMood(_ sender: AnyObject){
        let currentLocation : CLLocationCoordinate2D = MCLocationManager.sharedInstance.getCurrentLocation()
        
        let newMood : MCMood = MCMood(name: moodNameField.text! as NSString, notes:moodNotesField.text as NSString?, lat:currentLocation.latitude , lon: currentLocation.longitude, date: NSDate())
        let success : Bool = moodManager.addMoodToStore(mood: newMood)
        
        if !success{
            print("Couldn't add mood")
            
        }
        moodNotesField.resignFirstResponder()
        scrollingMoodView.setContentOffset(originalContentOffset, animated: true)
        notesView.isHidden = true
        self.view.endEditing(true)
        moodInputStatusField.isHidden = false
        
    }
    
    @IBAction func SaveNotes(_ sender: AnyObject){
        moodNotesField.resignFirstResponder()
        scrollingMoodView.setContentOffset(originalContentOffset, animated: true)
        notesView.isHidden = true
    }
    
    @IBAction func AddNotes(_ sender: AnyObject){
        addNotesButton.isHidden = true
        notesView.isHidden = false
        moodInputStatusField.isHidden = true
        scrollingMoodView.setContentOffset(CGPoint(x:scrollingMoodView.frame.origin.x, y:moodNameField.frame.origin.y+140), animated: true)
        moodNameField.isEnabled = false
        moodNotesField.becomeFirstResponder()
    
        
        
    }
    
    @IBAction func ViewHistory(_ sender: AnyObject){
        //let moodHistoryVC = MCHistoryViewController(categoryType: Constants.HISTORY_CATEGORY_TYPE.HISTORY_MOOD_ALL, arguments: nil)
        //self.present(moodHistoryVC, animated: true, completion: nil)
        
    }
    
   }
