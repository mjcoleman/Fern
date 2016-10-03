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

    @IBOutlet var contentView : UIView!
    @IBOutlet var moodTextField : UITextField!
    @IBOutlet var moodLocationField : UITextField!
    @IBOutlet var moodNotesView : UITextView!
    @IBOutlet var moodEntryScrollView : UIScrollView!
    
    //Helper Lables
    @IBOutlet var moodEntryLabel : UILabel!
    @IBOutlet var moodLocationLabel : UILabel!
    @IBOutlet var moodNotesLabel : UILabel!
    @IBOutlet var moodNotesHint : UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moodEntryScrollView.addSubview(contentView)
        moodEntryScrollView.contentSize = contentView.frame.size
        contentView.backgroundColor = UIColor.clear
        
        //Delegates
        moodTextField.delegate = self
        moodLocationField.delegate = self
        moodNotesView.delegate = self
        
        
        //Prepopulate Location Field
        let currentLocation : CLLocationCoordinate2D = MCLocationManager.sharedInstance.getCurrentLocation()
        if let locationName = MCMoodStoreManager.sharedInstance.getNameForLocation(location: currentLocation){
            //We have a location name.
            moodLocationField.text = locationName
        }
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        moodTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == moodTextField){
            moodLocationField.becomeFirstResponder()
            moodLocationLabel.text = "I'm Feeling \(moodTextField.text!) at"
            
            let scrollPoint = CGPoint(x: 0, y: moodLocationLabel.frame.origin.y)
            moodEntryScrollView.setContentOffset(scrollPoint, animated: true)
            
        }else if(textField == moodLocationField){
            moodNotesView.becomeFirstResponder()
            moodNotesLabel.text = "I'm Feeling \(moodTextField.text!) at \(moodLocationField.text!) because"
             let scrollPoint = CGPoint(x: 0, y: moodNotesLabel.frame.origin.y)
            moodEntryScrollView.setContentOffset(scrollPoint, animated: true)
            
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        moodNotesHint.isHidden = true
    }
    
    func getEnteredMoodData()->(String, String?, String?){
        return (moodTextField.text!, moodLocationField.text, moodNotesView.text)
    }
    
    @IBAction func enterMood(_ sender : AnyObject){
        let currentLocation : CLLocationCoordinate2D = MCLocationManager.sharedInstance.getCurrentLocation()
        let newMood : MCMood = MCMood(name: moodTextField.text! as NSString, notes: moodNotesView.text! as NSString, lat: currentLocation.latitude, lon: currentLocation.longitude, locName: moodLocationField.text, date: NSDate())
        MCMoodStoreManager.sharedInstance.addMoodToStore(mood: newMood)
        
        //Clear the UI
        moodLocationLabel.text = "at"
        moodNotesLabel.text = "because"
        
        moodNotesView.text = ""
        moodLocationField.text = ""
        moodTextField.text = ""
        
        self.view.removeFromSuperview()
        
        
        //Post a notification that we're done.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "moodAdded"), object: nil)
        
        
        
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
