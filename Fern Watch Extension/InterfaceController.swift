//
//  InterfaceController.swift
//  Fern Watch Extension
//
//  Created by Michael Coleman on 1/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var lastMoodTimeLabel: WKInterfaceLabel!
    @IBOutlet var lastMoodLabel: WKInterfaceLabel!
  
    var watchsession : WCSession!
    
  override func awake(withContext context: Any?) {
        super.awake(withContext: context)

    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if(WCSession.isSupported()){
            self.watchsession = WCSession.default()
            self.watchsession.delegate = self
            self.watchsession.activate()
            
        }
    
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func newMood() {
        self.presentTextInputController(withSuggestions: ["Test"], allowedInputMode: WKTextInputMode.plain, completion: { (answers) -> Void in
            if((answers?.count)! > 0){
                var answer = answers?.first as! String!
                self.watchsession.sendMessage(["newmood":answer!], replyHandler: nil, errorHandler: nil)
            }
            
        })
        
        

        

        
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        print("Received a message")
        lastMoodLabel.setText(message["moodname"]! as? String)
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }

}
