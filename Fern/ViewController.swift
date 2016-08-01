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


class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate{
    
    var locationOn : Bool = true
    var locationManager = CLLocationManager()
    var lastMood : MCMood?
    let moodManager : MCMoodStoreManager = MCMoodStoreManager()
    
    
    @IBOutlet var interfaceView : UIView!
    @IBOutlet weak var lastMoodLabel: UILabel!
    @IBOutlet weak var locationToggle: UISwitch!
    @IBOutlet weak var moodNoteField: UITextField!
    @IBOutlet weak var moodNameField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let colOne = UIColor.init(red: 1, green: 0.533, blue: 0.29, alpha: 1).cgColor
        let colTwo = UIColor.init(red: 1, green: 0.18, blue: 0, alpha: 1).cgColor
        gradientLayer.colors=[colOne,colTwo]
        gradientLayer.locations=[-0.5, 1.5]
        self.view.layer.addSublayer(gradientLayer)
        interfaceView.backgroundColor = UIColor.clear()
        self.view.addSubview(interfaceView)
        
        locationManager.delegate = self;
        moodNameField.delegate = self;
        moodNoteField.delegate = self;
        
        //Move to "first run" function.
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }
        
        
        self.setupInterface()
   
        
        // Do any additional setup after loading the view, typically from a nib.
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
        
        //Get last Mood from MoodManager
        lastMood = moodManager.getLastMood()
        if lastMood?.moodName == ""{
            //No last mood. HANDLE THIS
            
        }else{
            lastMoodLabel.text = lastMood?.moodName
        }
        
        
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            locationToggle.isEnabled = true
            locationManager.startUpdatingLocation()
            break;
        case .authorizedWhenInUse:
            locationToggle.isEnabled = false
            break;
        case .restricted:
            locationToggle.isEnabled = false
            break;
        case .denied:
            locationToggle.isEnabled = false
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
        let newMood : MCMood = MCMood(name: moodNameField.text!, notes: moodNoteField.text, lat:locationManager.location?.coordinate.latitude , lon: locationManager.location?.coordinate.longitude, date: NSDate())
        let success : Bool = moodManager.addMoodToStore(mood: newMood)
       
        if !success{
            print("Couldn't add mood")
            
        }
    
    }

}
