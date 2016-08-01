//
//  MCSettingsViewController.swift
//  Fern
//
//  Created by Michael Coleman on 27/07/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit

class MCSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
