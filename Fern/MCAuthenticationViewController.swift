//
//  MCAuthenticationViewController.swift
//  Fern
//
//  Created by Michael Coleman on 14/08/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit
import LocalAuthentication

class MCAuthenticationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //If TouchID is Set up, authenticate, else switch to primary view controller
        let authenticationContext = LAContext()
        
        var authenticationError : NSErrorPointer
        if(authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: authenticationError)){
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Test", reply: {(success, error)-> Void in
                if(success){
                    OperationQueue.main.addOperation({ () -> Void in
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainView")
                    self.present(mainVC!, animated: true, completion: nil)
                    })
                    
                }else{
                    print("error")
                }
            
        })
        
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
