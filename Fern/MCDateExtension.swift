//
//  MCDateExtension.swift
//  Fern
//
//  Created by Michael Coleman on 1/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import Foundation


extension NSDate{
    func timeDifferenceToString(date : NSDate) -> NSString{
        //Temporary, for demo purposes only. To be rewritten.
        
        let interval : TimeInterval = timeIntervalSince(date as Date)
        let intervalInSeconds : Double = interval as Double
        
        if intervalInSeconds < 60 {
            return "Just now"
        }
        if intervalInSeconds > 60 && intervalInSeconds < 120{
            return "A Minute Ago"
        }
        if intervalInSeconds > 120 && intervalInSeconds < 300{
            return "A Few Minutes Ago"
        }
        if intervalInSeconds > 300 && intervalInSeconds < 360{
            return "Five Minutes Ago"
        }
        if intervalInSeconds > 360 && intervalInSeconds < 600{
            return "Less than Ten Minutes Ago"
        }
        if intervalInSeconds > 600 && intervalInSeconds < 660{
            return "Ten Minutes Ago"
        }
        if intervalInSeconds > 660 && intervalInSeconds < 900{
            return "Less than Fifteen Minutes Ago"
        }
        if intervalInSeconds > 900 && intervalInSeconds < 960{
            return "Fifteen Minutes Ago"
        }
        
        
        return "An hour ago"
    }
    
    
    
    /*
     This function builds a String from self (NSDate), with options for showing Day of Hour, Min/Week/Day/Month/Year
     */
    func dateToString(hourmin : Bool, dayofweek: Bool, daymonth: Bool, year: Bool) -> String{
        let dateFormatter = DateFormatter()
        var formatString = ""
        
        if(hourmin){
            formatString += "HH:mm"
        }
        if(dayofweek){
            formatString += " EEEE"
        }
        
        if(daymonth){
            formatString += " MMM d"
        }
        if(year){
            formatString += " yyyy"
        }
      
        dateFormatter.dateFormat = formatString
        
        return dateFormatter.string(from: self as Date)
        
    }
    
    
    
}

