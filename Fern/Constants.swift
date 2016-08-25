//
//  Constants.swift
//  Fern
//
//  Created by Michael Coleman on 15/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import Foundation
import CoreLocation
class Constants{
    static let ALL_REQUESTS = 10000
    typealias MONTH_TUPLE = (name: String, countDays: Int, startDay: Int)
    typealias HISTORY_ARGUMENT_TUPLE = (moodName : String?, moodStart : NSDate?, moodEnd: NSDate?, moodLocation: CLLocationCoordinate2D?, viewSegments: [Bool]?)
    
    enum HISTORY_CATEGORY_TYPE : Int{
        case HISTORY_MOOD_NAME  = 0
        case HISTORY_MOOD_DATE = 1
        case HISTORY_MOOD_LOCATION = 2
        case HISTORY_MOOD_ALL = 3
    }
    
    
    
}
