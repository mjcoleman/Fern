//
//  MCMoodEntryViewController.swift
//  Fern
//
//  Created by Michael Coleman on 28/09/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit
import CoreLocation

class MCMoodEntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{

    @IBOutlet var moodTextField : UITextField!
    @IBOutlet var locationTextField : UITextField!
    
    
    
    @IBOutlet var moodEntryScrollView : UIScrollView!
    @IBOutlet var textFieldIconView : UIImageView!
    
    @IBOutlet var locationButton : UIButton!
    @IBOutlet var notesButton : UIButton!
    @IBOutlet var moodButton : UIButton!
    
    @IBOutlet var titleTextView : UITextField!
    
    
    
    @IBOutlet var stack : UIStackView!
    @IBOutlet var topStack : UIStackView!
    
    
    @IBOutlet var notesTextView : UITextView!
    
    
    var newMoodName : String = ""
    var newLocationName : String = ""
    var newNotes : String = ""
    
    var knownLocation : Bool = false
    var knownLocationName : String = ""
    
    var moodIconView : UIImageView!
    var textBoxImageString : String = "moodicon"
    
    
    var textBoxState : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear

        locationButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: -10, bottom: 3, right: 2)
        notesButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: -10, bottom: 3, right: 2)
        locationButton.titleEdgeInsets = UIEdgeInsets(top: 0, left:-10, bottom: 0, right: 5)
        notesButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 5)
        locationButton.imageView?.contentMode = .scaleAspectFit
        notesButton.imageView?.contentMode = .scaleAspectFit
        
        notesTextView.textContainerInset = UIEdgeInsets(top:30, left:0, bottom:0, right:0)
        

        locationButton.layer.borderColor = UIColor.white.cgColor
        locationButton.layer.borderWidth = 1.0
        notesButton.layer.borderColor = UIColor.white.cgColor
        notesButton.layer.borderWidth = 1.0
        moodButton.layer.borderColor = UIColor.white.cgColor
        moodButton.layer.borderWidth = 1.0
        moodButton.imageView?.contentMode = .scaleAspectFit
        
        
        let notesView = stack.arrangedSubviews[1]
        let locationView = stack.arrangedSubviews[2]
        moodButton.isHidden = true
        locationView.isHidden = true
        notesView.isHidden = true
        
        //Delegates
        
        moodTextField.delegate = self
        locationTextField.delegate = self
        
        notesTextView.delegate = self;
        
        
        //Prepopulate Location Field
        let currentLocation : CLLocationCoordinate2D = MCLocationManager.sharedInstance.getCurrentLocation()
        if let locationName = MCMoodStoreManager.sharedInstance.getNameForLocation(location: currentLocation){
            //We have a location name.
            locationButton.setTitle(locationName, for: .normal)
           locationButton.backgroundColor = UIColor.white
           locationButton.setTitleColor(UIColor.black, for: .normal)
            knownLocation = true
            knownLocationName = locationName
            locationTextField.text = locationName
            
            
            
        }
        
        self.view.layoutIfNeeded()

        
        
    }
    
    override func viewDidLayoutSubviews() {
      
        let insetView : UIView = UIView.init(frame: CGRect(x: 5, y: 0, width: (self.moodTextField.frame.size.height/2) + 5, height: self.moodTextField.frame.size.height))
        insetView.backgroundColor = moodTextField.backgroundColor
        moodIconView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: self.moodTextField.frame.size.height/2, height: self.moodTextField.frame.size.height))
        moodIconView.image = UIImage.init(imageLiteralResourceName: textBoxImageString as String)
        moodIconView.contentMode = .scaleAspectFit
        insetView.addSubview(moodIconView)
        moodTextField.leftView = insetView
        moodTextField.leftViewMode = .always
        
        let locationInsetView : UIView  = UIView.init(frame: CGRect(x: 5, y: 0, width: (self.locationTextField.frame.size.height/2) + 5, height: self.locationTextField.frame.size.height))
            locationInsetView.backgroundColor = locationTextField.backgroundColor
       let locationIconView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: self.locationTextField.frame.size.height/2, height: self.locationTextField.frame.size.height))
        locationIconView.image = UIImage.init(imageLiteralResourceName: "locationicon")
        locationIconView.contentMode = .scaleAspectFit
        locationInsetView.addSubview(locationIconView)
        
        locationTextField.leftView = locationInsetView
        locationTextField.leftViewMode = .always
        
      
        
        
        if newMoodName == ""{
            
        }else{
//            moodButtonLabel.text = newMoodName
//            moodButtonLabel.frame = CGRect(x: moodButtonIcon.frame.origin.x + moodButtonIcon.frame.size.width, y: moodButtonLabel.frame.origin.y, width: moodButtonLabel.frame.size.width, height: moodButtonLabel.frame.size.height)
//            moodButtonView.layer.borderColor = UIColor.white.cgColor
//            moodButtonView.layer.borderWidth = 1.0
//            moodButtonView.backgroundColor = UIColor.white
//            moodButtonLabel.textColor = UIColor.black
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
      //  moodTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        notesTextView.text = ""
        notesTextView.textContainerInset=UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        notesTextView.textColor = UIColor.black
        notesTextView.font? = UIFont(name: (notesTextView.font?.familyName)!, size: 14)!
        
    }
    
//    func getEnteredMoodData()->(String, String?, String?){
//        //return (moodTextField.text!, moodLocationField.text, moodNotesView.text)
//    }
    
    @IBAction func saveMood(_ sender : AnyObject){
       let currentLocation : CLLocationCoordinate2D = MCLocationManager.sharedInstance.getCurrentLocation()
       let newMood : MCMood = MCMood(name: newMoodName as NSString, notes: newNotes as NSString, lat: currentLocation.latitude, lon: currentLocation.longitude, locName: newLocationName, date: NSDate())
        MCMoodStoreManager.sharedInstance.addMoodToStore(mood: newMood)
        

        self.view.removeFromSuperview()
        
       
        //Post a notification that we're done.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "moodAdded"), object: nil)
        
        
        
}
    
    
    func switchTextBoxState(newState : Int){
        
        let locationview = stack.arrangedSubviews[2]
        let notesview = stack.arrangedSubviews[1]
        let moodview = stack.arrangedSubviews[0]
        
        switch textBoxState{
        case 0:
            //User was entering mood.
            newMoodName = moodTextField.text!
            
            if newMoodName == ""{
                moodButton.setTitle("Enter Mood", for: .normal)
                
                
            }else{
                moodButton.setTitle(newMoodName, for: .normal)
                moodButton.backgroundColor = UIColor.white
                moodButton.setTitleColor(UIColor.black, for: .normal)
                
            }
            moodButton.isHidden = false
            titleTextView.isHidden = true
            
            moodTextField.resignFirstResponder()
            break;
        case 1:
            //User was entering location.
            newLocationName = locationTextField.text!
            
            
            if  newLocationName == ""{
               locationButton.setTitle("Location", for: .normal)
            locationButton.backgroundColor = UIColor.clear
                locationButton.setTitleColor(UIColor.white, for: .normal)
                
            }else{
               locationButton.setTitle(newLocationName, for: .normal)
                
                locationButton.backgroundColor = UIColor.white
                locationButton.setTitleColor(UIColor.black, for: .normal)
                
                
            }
            locationTextField.resignFirstResponder()
            
            break;
        case 2:
            //User was entering notes.
            newNotes = moodTextField.text!
            
            if(newNotes == ""){
               notesButton.setTitle("Add Notes", for: .normal)
                
               notesButton.backgroundColor = UIColor.clear
               notesButton.setTitleColor(UIColor.black, for: .normal)
                
                self.view.layoutIfNeeded()
            }else{
                notesButton.setTitle("Notes", for: .normal)
                notesButton.backgroundColor = UIColor.white
                notesButton.setTitleColor(UIColor.black, for: .normal)
                
            }
            notesTextView.resignFirstResponder()
            break;
        default:
            break;
            
        }
        
        switch newState{
        case 0:
            //Heading to mood.
            
            if(newMoodName != ""){
                moodTextField.text = newMoodName
            }else{
                moodTextField.text = ""
                moodTextField.placeholder = "Mood"
            }
            moodButton.isHidden = true
            titleTextView.isHidden = false
            
            moodview.isHidden = false
            notesview.isHidden = true
            locationview.isHidden = true
            break;
        case 1:
            //Heading to location.

            locationButton.backgroundColor = UIColor.gray
            locationButton.isEnabled = false
            notesButton.isEnabled = true
            
            if(newLocationName != ""){
                
                locationTextField.text = newLocationName
            }else{
                if knownLocation{
                    locationTextField.text = knownLocationName
                }else{
                    locationTextField.text = ""
                    locationTextField.placeholder = "Name"
                    }
                }
           locationTextField.becomeFirstResponder()
            moodview.isHidden = true
            notesview.isHidden = true
            locationview.isHidden = false
             
            
            break;
        case 2:
            //Heading to notes.
            
          
            notesButton.isEnabled = false
            locationButton.isEnabled = true
            if(newNotes != ""){
                moodTextField.text = newNotes;
                
            }else{
                moodTextField.text = ""
                
            }
            notesTextView.becomeFirstResponder()
            moodview.isHidden = true
            notesview.isHidden = false
            locationview.isHidden = true
            
            break;
        default:
            break;
        }
        
        textBoxState = newState
        self.view.layoutIfNeeded()
    }
    
    @IBAction func enterlocation(_ sender : AnyObject){
      
        switchTextBoxState(newState: 1)
      
        
    }
    
    @IBAction func enterMood(_ sender : AnyObject){
        switchTextBoxState(newState: 0)
    }
    
    @IBAction func enterNotes(_ sender: AnyObject){
        switchTextBoxState(newState: 2)
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
