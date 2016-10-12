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

  
    
    var newMoodName : String = ""
    var newLocationName : String = ""
    var newNotes : String = ""
    
    var knownLocation : Bool = false
    var knownLocationName : String = ""
    
    
    @IBOutlet var moodLeftPad : UILabel!
    @IBOutlet var moodButton : UIButton!
    @IBOutlet var moodTextField : UITextField!
    @IBOutlet var moodLabel : UILabel!
    @IBOutlet var moodBackingView : UIView!

    
    @IBOutlet var locationLeftPad : UILabel!
    @IBOutlet var locationButton : UIButton!
    @IBOutlet var locationTextField : UITextField!
    @IBOutlet var locationLabel : UILabel!
    @IBOutlet var locationBackingView : UIView!
    
    
    @IBOutlet var notesLeftPad : UILabel!
    @IBOutlet var notesButton : UIButton!
    @IBOutlet var notesTextField : UITextField!
    @IBOutlet var notesLabel : UILabel!
    @IBOutlet var notesBackingView : UIView!
    
    var currentViewMode : Int = 0 //Mood View Mode
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        //Initial Setup.
        moodLeftPad.isHidden = true
        moodLabel.isHidden = true
        moodButton.imageView?.contentMode = .scaleAspectFit
        
        
        locationTextField.isHidden = true;
        locationLabel.alpha = 0.0
        locationLeftPad.alpha = 0.0
        locationBackingView.backgroundColor = UIColor.clear
        locationButton.imageView?.contentMode = .scaleAspectFit
        
        notesTextField.isHidden = true;
        notesLabel.alpha = 0.0
        notesLeftPad.alpha = 0.0
        notesBackingView.backgroundColor = UIColor.clear
        notesButton.imageView?.contentMode = .scaleAspectFit
        
        
        //Delegates
        
        moodTextField.delegate = self
        
    }
    
        
        //Prepopulate Location Field
//        let currentLocation : CLLocationCoordinate2D = MCLocationManager.sharedInstance.getCurrentLocation()
//        if let locationName = MCMoodStoreManager.sharedInstance.getNameForLocation(location: currentLocation){
//            //We have a location name.
//            locationButton.setTitle(locationName, for: .normal)
//           locationButton.backgroundColor = UIColor.white
//           locationButton.setTitleColor(UIColor.black, for: .normal)
//            knownLocation = true
//            knownLocationName = locationName
//            locationTextField.text = locationName
//            
//            
//            
//        }
        
    

        
        
    
    
    override func viewDidLayoutSubviews() {
      
    
      
    }


    func switchViewMode(viewMode : Int){
        
        switch currentViewMode{
        case 0:
            //Currently editing mood.
            if(moodTextField.text != ""){
                //User has entered a mood.
                newMoodName = moodTextField.text!
                moodTextField.textColor = UIColor.white
                moodTextField.textAlignment = .center
                UIView.animate(withDuration: 0.2, animations: {
                    //self.moodTextField.isHidden = true;
                    self.moodTextField.backgroundColor = UIColor.clear
                    self.moodLeftPad.isHidden = false
                    self.moodLabel.isHidden = false
                    self.moodLabel.alpha = 0.0
                    self.moodLeftPad.alpha = 0.0
                    self.moodLabel.text = self.newMoodName
                    self.moodBackingView.backgroundColor = UIColor.clear
                    self.moodButton.isHidden = true
                    
                })
            }else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.moodTextField.isHidden = true;
                    self.moodLeftPad.isHidden = false
                    self.moodLeftPad.alpha = 1.0
                    self.moodLeftPad.text = "Enter a Mood"
                    self.moodLabel.isHidden = false
                    self.moodLabel.alpha = 0.0
                    self.moodLabel.text = self.newMoodName
                    self.moodBackingView.backgroundColor = UIColor.clear
                })
                
            }
            
            break;
        case 1:
            //Currently editing location.
            if(locationTextField.text != ""){
                //User has entered a location.
                newLocationName = locationTextField.text!
               // locationTextField.text = ""
               locationTextField.textColor = UIColor.white
                locationTextField.textAlignment = .center
                UIView.animate(withDuration: 0.2, animations: {
                    self.locationTextField.isHidden = false;
                    self.locationTextField.backgroundColor = UIColor.clear

                    self.locationLeftPad.isHidden = false
                    self.locationLabel.isHidden = false
                    self.locationLabel.alpha = 0.0
                    self.locationLeftPad.alpha = 0.0
                    self.locationLabel.text = self.newLocationName
                    self.locationBackingView.backgroundColor = UIColor.clear
                    
                })
            }else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.locationTextField.isHidden = true;
                    self.locationLeftPad.isHidden = false
                    self.locationLeftPad.alpha = 0.0
                    self.locationLabel.isHidden = false
                    self.locationLabel.alpha = 0.0
                    self.locationLabel.text = self.newLocationName
                    self.locationBackingView.backgroundColor = UIColor.clear
                })
                
            }

            
            break;
        case 2:
            if(notesTextField.text != ""){
                //User has entered a notes.
                newNotes = notesTextField.text!
                notesTextField.text = ""
                UIView.animate(withDuration: 0.2, animations: {
                    self.notesTextField.isHidden = true;
                    self.notesLeftPad.isHidden = false
                    self.notesLabel.isHidden = false
                    self.notesLabel.alpha = 1.0
                    self.notesLeftPad.alpha = 0.0
                    self.notesLabel.text = self.newNotes
                    self.notesBackingView.backgroundColor = UIColor.clear
                })
            }else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.notesTextField.isHidden = true;
                    self.notesLeftPad.isHidden = false
                    self.notesLeftPad.alpha = 1.0
                    self.notesLeftPad.text = "Enter a notes"
                    self.notesLabel.isHidden = false
                    self.notesLabel.alpha = 0.0
                    self.notesLabel.text = self.newNotes
                    self.notesBackingView.backgroundColor = UIColor.clear
                })
                
            }

            break;
        default:
            break;
        }
        
        switch viewMode{
        case 0:
            //Want to edit mood.
            moodTextField.textColor = UIColor.black
            UIView.animate(withDuration: 0.2, animations: {
                self.moodTextField.isHidden = false;
                self.moodLeftPad.isHidden = true
                self.moodLabel.isHidden = true
                self.moodBackingView.backgroundColor = UIColor.white
                
            })
            if(newMoodName != ""){
                self.moodTextField.text = newMoodName
            }
            break;
        case 1:
            locationTextField.textColor = UIColor.black
            UIView.animate(withDuration: 0.2, animations: {
                self.locationTextField.isHidden = false;
                self.locationLeftPad.isHidden = true
                self.locationLabel.isHidden = true
                self.locationBackingView.backgroundColor = UIColor.white
            })
            locationTextField.becomeFirstResponder()
            if(newLocationName != ""){
                self.locationTextField.text = newLocationName
            }
            break;
        case 2:
            break;
        default:
            break;
            
        }
        
        currentViewMode = viewMode
        
        
        
    }

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.moodTextField{
            switchViewMode(viewMode: 0)
            
        }
        
    }
    
    @IBAction func changeMood(_ sender : AnyObject){
        switchViewMode(viewMode: 0)
    }
   
    @IBAction func changeLocation(_ sender : AnyObject){
        switchViewMode(viewMode: 1)
        
    }
    
    @IBAction func changeNotes(_ sender : AnyObject){
        switchViewMode(viewMode: 2)
        
    }


}
