//
//  MCLocationManager.swift
//  Fern
//
//  Created by Michael Coleman on 4/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit
import CoreLocation

class MCLocationManager: NSObject, CLLocationManagerDelegate{
    static let sharedInstance  = MCLocationManager()
    var locationEnabled = false;
    var clManager = CLLocationManager()
    
    
    override init(){
        super.init()
        if CLLocationManager.authorizationStatus() == .notDetermined{
            clManager.requestAlwaysAuthorization()
        }
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            clManager.startUpdatingLocation()
            break;
        case .authorizedWhenInUse:
            break;
        case .restricted:
            break;
        case .denied:
            break
        default:
            break
        }
    }
    
    func getCurrentLocation() -> CLLocationCoordinate2D{
        return (clManager.location?.coordinate)!
    }
    
    func checkLocationExists(lat : Double, lon: Double)->Bool{
        return false
    }
    
    func nameLocation(lat : Double, lon : Double){
        //Search the store for this location, 
        //Add field in locationname.
        
    }
}
