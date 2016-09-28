//
//  MCNotesViewController.swift
//  Fern
//
//  Created by Michael Coleman on 4/09/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit

class MCNotesViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var notesTextView : UITextView!
    @IBOutlet var moodLabel : UILabel!
    @IBOutlet var doneButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesTextView.becomeFirstResponder()
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
