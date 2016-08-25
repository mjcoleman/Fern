//
//  MCMoodStoreManager.swift
//  Fern
//
//  Created by Michael Coleman on 1/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//  This class will manage getting and setting moods into the CoreData store.



import UIKit
import CoreData
import CoreLocation

class MCMoodStoreManager: NSObject {
    static let sharedInstance = MCMoodStoreManager()
    
    let appDel : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
    var container : NSPersistentContainer?
    
    
    override init(){
        container = appDel.persistentContainer
    }
    
    
    /*
     Will retrieve the latest mood from CoreData store, convert it to a MCMood Object and return it.
     If there is none, we'll return an empty mood object.
     */
    func getLastMood() -> MCMood{
        print("Called get last mood")
        
        var lastMood = MCMood(name: "", notes: "", lat: 0.0, lon: 0.0, date: NSDate.distantPast as NSDate)
        
        //Get the count of items in the data store
        let countRequest : NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoodObject")
        countRequest.resultType = .countResultType
        var moodCount : NSInteger
       
        do{
            try moodCount = (container?.viewContext.count(for: countRequest))!
        }catch {
            moodCount = 0
        }
        
        if moodCount == 0{
            return lastMood
        }
        
        
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoodObject")
            request.fetchLimit = 1
            request.fetchOffset = (moodCount - 1)
            let result = try container?.viewContext.fetch(request)
            lastMood = MCMood(object: result?.first! as! NSManagedObject)
            MCWatchSessionManager.sharedInstance.sendMoodToWatch(mood: lastMood)
            
            
            
        }catch{
            //Error getting the last mood.
        }
            
        
        return lastMood
    }
    
    /*
    Adds an MCMood to the core data store, returns true if stored successfully, false otherwise.
     */
    func addMoodToStore(mood : MCMood) -> Bool{
        
        let newMood = NSEntityDescription.insertNewObject(forEntityName: "MoodObject", into: (container?.viewContext)!)
        newMood.setValue(mood.moodName, forKey: "moodname")
        newMood.setValue(mood.moodNotes, forKey: "moodnotes")
        
        if mood.hasLocation{
            
            newMood.setValue(mood.moodLat, forKey: "moodlat")
            newMood.setValue(mood.moodLon, forKey: "moodlon")
        }
        
        
        
        let currentDate  = NSDate()
        
        newMood.setValue(currentDate, forKey: "mooddate")
        do{
            try container?.viewContext.save()
            MCWatchSessionManager.sharedInstance.sendMoodToWatch(mood: mood)
        }catch{
            //Error Saving Mood.
            print("Error when saving mood")
            return false
            
        }
        
        return true
        
    }
    
    
    /*
     Will retrieve all Moods from the core data store, convert them to an MCMood, add them to an array and return that array.
     */
    func getMoodsFromStore(number : Int)->[MCMood]{
        var allMoods : [MCMood]=[]
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoodObject")
            if(number < Constants.ALL_REQUESTS){
                request.fetchLimit = number
            }
            let allResults = try container?.viewContext.fetch(request)
            for obj in allResults!{
                var mood : MCMood = MCMood(object: obj as! NSManagedObject)
                allMoods.append(mood)
            }
           
        }catch{
            //Error getting moods. Make sure we return an empty array.
            allMoods = [];
            
        }
        return allMoods

    }
    
    
    /*
     Will retrieve moods within a specified date range.
    */
    func getMoodsForPeriod(from : NSDate, to : NSDate)->[MCMood]{
        var moods : [MCMood] = []
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoodObject")
            let datePredicate : NSPredicate = NSPredicate(format:"mooddate >= %@ && mooddate < %@", from, to)
            request.predicate = datePredicate;
            
            let dateResults = try container?.viewContext.fetch(request)
            for obj in dateResults!{
                var mood : MCMood = MCMood(object: obj as! NSManagedObject)
                moods.append(mood)
            }
            
        }catch{
            //Error getting moods OR no moods in range. Make sure we return an empty array.
            moods = []
            
        }
        
        
        return moods;
    }
    
    
    /*
     Retrieve All Moods with a specific MoodName. Case Insensitive [c].
    */
    func getMoodsForMoodName(name : String)->[MCMood]{
        var moods : [MCMood] = []
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoodObject")
            let namePredicate : NSPredicate = NSPredicate(format: "moodname ==[c] %@", name)
            request.predicate = namePredicate
            
            let nameResults = try container?.viewContext.fetch(request)
            for obj in nameResults!{
                var mood : MCMood = MCMood(object: obj as! NSManagedObject)
                moods.append(mood)
            }
        }catch{
            //Error getting moods OR no moods with name. Make sure we return an empty array.
            moods = []
        }
        
        return moods
        
    }
    
    
    
    /*
     Returns how many times a mood matching 'name' has been entered
    */
    func getCountForMoodName(name: String)->Int{
        return self.getMoodsForMoodName(name: name).count
    }
 
    
    
    /*
     Looks through all moods to find most common moods and returns those as a string array.
    */
    func getMostCommonMoods(inDateRange: (dstart: NSDate, dend: NSDate)?, inLocation:CLLocationCoordinate2D?)->String{
        var moodsToTest : [MCMood] = []
        
        if(inDateRange?.dstart != nil){
            //Sort by date first.
            moodsToTest = self.getMoodsForPeriod(from: (inDateRange?.dstart)!, to: (inDateRange?.dend)!)
            
        }else if(inLocation != nil){
            //Sort by location first
            moodsToTest = self.getMoodsForLocation(location: inLocation!);
        
        }else{
            //We're looking for most common in all moods.
            moodsToTest = self.getMoodsFromStore(number: Constants.ALL_REQUESTS)
        }
        
        
        //This is a nightmare.
        //Put all mood names into an array of strings.
        var moodNames : [String] = []
        
        for x in moodsToTest{
            let mood : MCMood = x as MCMood
            moodNames.append(mood.moodName)
        }
        
        
        //Count how many times each mood is in that array and make a dictionary
        var counts : [String:Int] = [:]
        for c in moodNames{
            counts[c] = (counts[c] ?? 0) + 1
        }
   
        //Sort them into an array of tuples (because we can't sort a dictionary
        let sortedCounts = counts.sorted{$0.value > $1.value}
        
        //If the top two have the same amount of moods entered, forget the whole thing, no most common mood.
        if(sortedCounts[0].1 == sortedCounts[1].1){
            return "";
        }
        
        //Otherwise we have a winner, return that.
        return sortedCounts[0].0
    }
    

    
    
    func getMoodsForLocation(location : CLLocationCoordinate2D)->[MCMood]{
        var moods : [MCMood] = []
        
        return moods
    }
    
    
    
    /*
     May be better to use something like this function as a general rule.
    */
    func getMoodsWithPredicate(pred : NSPredicate)->[MCMood]{
        var moods : [MCMood] = []
        
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoodObject")
            request.predicate = pred
            
            let results = try container?.viewContext.fetch(request)
            for obj in results!{
                var mood : MCMood  = MCMood(object: obj as! NSManagedObject)
                moods.append(mood)
            }
            
        }catch{
            //Error getting moods OR no moods matching predicate. Make sure we return an empty array.
            moods = []
        }
        
        return moods
    }
    


}
