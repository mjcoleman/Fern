//
//  MCMoodStoreManager.swift
//  Fern
//
//  Created by Michael Coleman on 1/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//  This class will manage getting and setting moods into the CoreData store.



import UIKit
import CoreData


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
        
        var lastMood = MCMood(name: "", notes: "", lat: 0.0, lon: 0.0, date: NSDate.distantPast)
        
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
    func getMoodsFromStore()->[MCMood]{
        var allMoods : [MCMood]=[]
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoodObject")
            let allResults = try container?.viewContext.fetch(request)
            for obj in allResults!{
                var mood : MCMood = MCMood(object: obj as! NSManagedObject)
                allMoods.append(mood)
            }
           
        }catch{
            
        }
        return allMoods

    }
    
    
    /*
     Will return all moods from the core data store sorted via a key.
     */
    func sortMoodsFromStore(key : String)->[MCMood]{
        return []
        
    }


}
