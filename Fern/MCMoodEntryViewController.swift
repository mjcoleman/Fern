//
//  MCMoodEntryViewController.swift
//  Fern
//
//  Created by Michael Coleman on 28/09/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit

class MCMoodEntryViewController: UIViewController {

    @IBOutlet var contentView : UIView!
    @IBOutlet var moodTextField : UITextField!
    @IBOutlet var moodLocationField : UITextField!
    @IBOutlet var moodNotesView : UITextView!
    @IBOutlet var moodEntryScrollView : UIScrollView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moodEntryScrollView.addSubview(contentView)
        moodEntryScrollView.contentSize = contentView.frame.size
        
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
