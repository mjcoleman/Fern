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
            return "JUST NOW "
        }
        if intervalInSeconds > 60 && intervalInSeconds < 3600{
            let mins : Int = (Int(intervalInSeconds) / 60)
            if(mins == 1){
                return "\(mins) MINUTE AGO" as NSString
            }
            return "\(mins) MINUTES AGO" as NSString
        }
        if intervalInSeconds > 3600 && intervalInSeconds  < 86400{
            let hours : Int = (Int(intervalInSeconds) / 60) / 60
            if(hours == 1){
                return "\(hours) HOUR AGO" as NSString
            }
            return "\(hours) HOURS AGO" as NSString
            
        }
        if intervalInSeconds > 86400 && intervalInSeconds < 604800{
            let days : Int = (Int((intervalInSeconds) / 60) / 60) / 24
            if(days == 1){
                return "\(days) DAY AGO" as NSString

            }
            return "\(days) DAYS AGO" as NSString
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
            formatString += " MMMM d"
        }
        if(year){
            formatString += " yyyy"
        }
      
        dateFormatter.dateFormat = formatString
        
        return dateFormatter.string(from: self as Date)
        
    }
    
    
    func countOfThisDateInDates(dates : [NSDate])->Int{
        let dateString : String = self.dateToString(hourmin: false, dayofweek: false, daymonth: true, year: true);
        var count : Int = 0;
        for i in dates{
            let iDate : String = i.dateToString(hourmin: false, dayofweek: false, daymonth: true, year: true)
            if dateString == iDate{
                count += 1
            }
        }
        return count
    }
    
    
    
    

    
    
}

