//
//  MCMood.swift
//  Fern
//
//  Created by Michael Coleman on 27/07/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//
//This class will take a NSManagedObject and turn it into a new, more easily accessible MCMood

import UIKit
import MapKit
import CoreData


class MCMood: NSObject {
    
    //Mood Object Setters
    var moodName : String = ""
    var moodNotes : String?
    var moodDate : NSDate?
    var moodLat : Double=0
    var moodLon : Double=0
    var moodLocation : CLLocationCoordinate2D?
    var hasLocation : Bool = false;
    var moodLocationName : String?
    
   init(object : NSManagedObject){
    
    let loc : NSManagedObject = object.value(forKey: "moodlocation") as! NSManagedObject
    
        
        moodLat = (loc.value(forKey: "locationlat")) as! Double!
        moodLon = (loc.value(forKey: "locationlon")) as! Double!
        moodLocationName = (loc.value(forKey: "locationname")) as! String!
    
    if moodLat == 0{
        if moodLon == 0{
            hasLocation = false
        }
    }else{
        moodLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(moodLat), longitude: CLLocationDegrees(moodLon))
        hasLocation = true
    }

        moodName = object.value(forKey: "moodname") as! String
        moodNotes = object.value(forKey: "moodnotes") as? String

    let date : NSManagedObject = object.value(forKey: "mooddate") as! NSManagedObject
    
    moodDate = date.value(forKey: "date") as! NSDate!
    
    }
    
    
    init(name : NSString, notes : NSString?, lat : Double?, lon : Double?, date : NSDate){
        moodName = name as String
        moodNotes = notes as String?
        moodLat = (lat as Double?)!
        moodLon = (lon as Double?)!
        moodDate = date
        
        if moodLat == 0{
            if moodLon == 0{
                hasLocation = false
            }
        }else{
            moodLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(moodLat), longitude: CLLocationDegrees(moodLon))
            hasLocation = true
        }
    }
    
}
