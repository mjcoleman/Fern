//
//  MCDetailsInfoViewController.swift
//  Fern
//
//  Created by Michael Coleman on 2/10/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit
import MapKit

class MCDetailsInfoViewController: UIViewController {

    //Notes View Outlets
    @IBOutlet var notesView : UIView?
    @IBOutlet var notesViewTextView : UITextView?
    
    
    //Location View Outlets
    @IBOutlet var locationView : UIView?
    @IBOutlet var locationViewMapView : MKMapView?
    
    
    //Trend View Outlets
    @IBOutlet var trendsView : UIView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesView?.backgroundColor = UIColor.clear
        locationView?.backgroundColor = UIColor.clear
        trendsView?.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
