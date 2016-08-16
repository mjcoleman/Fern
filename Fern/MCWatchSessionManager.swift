//
//  MCWatchSessionManager.swift
//  Fern
//
//  Created by Michael Coleman on 4/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit
import WatchConnectivity

class MCWatchSessionManager: NSObject, WCSessionDelegate  {
    static let sharedInstance = MCWatchSessionManager()
    var watchsession : WCSession!
    
    override init(){
        super.init()
        
        if(WCSession.isSupported()){
            self.watchsession = WCSession.default()
            self.watchsession.delegate = self
            self.watchsession.activate()
            
        }
    }
    
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        //Construct a MCMood with message received from watch.
        var newmood : MCMood = MCMood.init(name:(message["newmood"]! as? String)! as NSString, notes: "", lat: 0, lon: 0, date: NSDate())
        var success : Bool = MCMoodStoreManager.sharedInstance.addMoodToStore(mood: newmood)
        if(!success){
            //Didn't save mood.
        }
       // NotificationCenter.default.post(name: "updateUI" as NSNotification.Name, object: self)
     
    }
    
    
    /*
     Recieved a mood back from watchOS, send it to the core data store.
     TODO: log location in here.
    */
    func session(_ session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        //We got a mood back.
        //Construct a MCMood with message received from watch.
        var newmood : MCMood = MCMood.init(name:(message["newmood"]! as? String)! as NSString, notes: "", lat: 0, lon: 0, date: NSDate())
        var success : Bool = MCMoodStoreManager.sharedInstance.addMoodToStore(mood: newmood)
        if(!success){
            //Didn't save mood.
        }
        //NotificationCenter.default.post(name: "updateUI" as NSNotification.Name, object: self)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }

    func sessionDidDeactivate(_ session: WCSession) {
        
        
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sendMoodToWatch(mood : MCMood){
        watchsession.sendMessage(["moodname" : mood.moodName], replyHandler: nil, errorHandler: nil);
//        watchsession.sendMessage(["mooddate" : NSDate().timeDifferenceToString(date: mood.moodDate!)], replyHandler: nil, errorHandler: nil)
        
        
    }
    
}
