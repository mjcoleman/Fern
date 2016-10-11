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
    var didAnimateHistory : Bool = false
    
    
    @IBOutlet var showHistoryButton : UIButton!
    @IBOutlet var newMoodButton : UIButton!
    @IBOutlet var logoLabel : UILabel!
    @IBOutlet var subLogoLabel : UILabel!
    
    
    @IBOutlet var historyScrollView : MCHomeHistoryScrollView!
    

    //Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
        //Move to "first run" function.
        self.locationOn = locationManager.locationEnabled
        
        
        
        //Notification center stuff
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupInterface), name:NSNotification.Name(rawValue: "updateUI"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupInterface), name:NSNotification.Name(rawValue: "backgrounded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.moodSelected(notification:)), name:NSNotification.Name(rawValue: "moodSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.moodAdded), name:NSNotification.Name(rawValue: "moodAdded"), object: nil)

        
    }
    override func viewDidAppear(_ animated: Bool) {
        if !didAnimateHistory{
            animateHistory()
            
        }
    }
    
    func animateHistory(){
        var entries = historyScrollView.moodViews
        
        for entry in entries!{
            entry.view.transform = CGAffineTransform(translationX: 0, y: historyScrollView.bounds.size.height)
            entry.view.alpha = 0.0
        }
        
        var timingDelay : Float = 0.0
        for entry in entries!{
            UIView.animate(withDuration: 1, delay: Double(timingDelay * 0.08), options: .curveEaseOut, animations: {
                entry.view.transform = CGAffineTransform.identity
                entry.view.alpha = 1.0
                }, completion: nil)
            timingDelay += 1
        }
        
        
        
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {

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
        if(historyScrollView.currentMoodCount == 0){
            self.setupInterface()
        }
        
        
    }
    

    func moodSelected(notification : NSNotification){
        let moodDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "mooddetails") as! MoodDetailsViewController
        moodDetailsVC.moodData = notification.userInfo?["Mood"] as? MCMood
        self.navigationController?.pushViewController(moodDetailsVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailssegue" {
        }else if segue.identifier == "moodhistory"{
            let moodHistoryVC = segue.destination as! MCHistoryViewController
          
            
            moodHistoryVC.setupView(categoryType: Constants.HISTORY_CATEGORY_TYPE.HISTORY_MOOD_ALL, arguments: nil)
        }
    }
    
    
    //Functions
    func setupInterface(){
        var viewy : Int = (Int) (historyScrollView.frame.size.height / 4);

        
        if(historyScrollView.currentMoodCount == 0){
            //Get last 5 moods from mood manager
            var moods : [MCMood] = moodManager.getMoodsFromStore(number: 5)
            
            //Reverse so they are top down order
            moods = moods.reversed()
            
            
            
            
            for m : MCMood in moods{
                let moodView = MCMainPageHistoryItemViewController();
                moodView.mood = m
                addChildViewController(moodView)
                
                moodView.view.frame = CGRect(x: 0, y: viewy, width: Int(historyScrollView.frame.size.width), height: 65);
                
                historyScrollView.addSubview(moodView.view);
                viewy += (65 + (Int)(historyScrollView.frame.size.height / 6));
                historyScrollView.currentMoodCount+=1
                historyScrollView.moodViews.append(moodView)
                
            }
            
            historyScrollView.contentSize = CGSize(width: (Int)(historyScrollView.frame.size.width), height: viewy + 500);
            
        }else{
            //Moods already loaded, move all moods down and add the new one.
            historyScrollView.contentSize = CGSize(width: historyScrollView.frame.size.width, height: historyScrollView.frame.size.height + (65 * CGFloat(historyScrollView.currentMoodCount)))
            
            for m : MCMainPageHistoryItemViewController in historyScrollView.moodViews{
                UIView.animate(withDuration: 0.5, animations: {
                    m.view.frame = CGRect(x: m.view.frame.origin.x, y: m.view.frame.origin.y + (60 + self.historyScrollView.frame.size.height/6), width: m.view.frame.width, height: m.view.frame.height)
                    
                })
                
            
            
                
            }
            let newMood = MCMoodStoreManager.sharedInstance.getLastMood()
            let newMoodView = MCMainPageHistoryItemViewController()
            newMoodView.mood = newMood
            addChildViewController(newMoodView)
            newMoodView.view.frame = CGRect(x: 0, y: viewy, width: Int(historyScrollView.frame.size.width), height: 65);
            historyScrollView.addSubview(newMoodView.view)
            historyScrollView.currentMoodCount+=1
            historyScrollView.moodViews.append(newMoodView)
            
        }
        
        

        
        
        

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
//            self.historyScrollView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.historyScrollView.frame.size.width, height: self.historyScrollView.frame.size.height)
            self.historyScrollView.alpha = 0.0
            self.newMoodButton.alpha = 0.0
            self.showHistoryButton.alpha = 0.0
           self.logoLabel.alpha = 0.0
              self.subLogoLabel.alpha = 0.0
//            self.newMoodButton.frame = CGRect(x: self.newMoodButton.frame.origin.x, y: self.newMoodButton.frame.origin.y + 80, width: self.newMoodButton.frame.size.width, height: self.newMoodButton.frame.size.height)
//            
        })
        
        
        let moodEntry = MCMoodEntryViewController()
        addChildViewController(moodEntry)
        moodEntry.view.frame = CGRect(x:0 , y: 10, width: self.view.frame.size.width, height: self.view.frame.size.height/1.6)
       // moodEntry.contentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: moodEntry.view.frame.size.height/1.6)
        self.view.addSubview(moodEntry.view)
      //  moodEntry.moodTextField.becomeFirstResponder()

    }
    

    func moodAdded(){
        
        
        //Animations to come.
        self.historyScrollView.alpha = 1.0
        self.newMoodButton.alpha = 1.0
        self.showHistoryButton.alpha = 1.0
        self.subLogoLabel.alpha = 1.0
        
        let originPoint = CGPoint(x: 0, y: 0)
        
        self.historyScrollView.setContentOffset(originPoint, animated: true)
        self.setupInterface()
    
    }
    
    @IBAction func ViewHistory(_ sender: AnyObject){
        //let moodHistoryVC = MCHistoryViewController(categoryType: Constants.HISTORY_CATEGORY_TYPE.HISTORY_MOOD_ALL, arguments: nil)
        //self.present(moodHistoryVC, animated: true, completion: nil)
        
    }
    
   }
