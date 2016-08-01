//
//  MCHistoryViewController.swift
//  Fern
//
//  Created by Michael Coleman on 27/07/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit
import CoreData

class MCHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var moodObjects : [MCMood]?
    let manager : MCMoodStoreManager = MCMoodStoreManager()
    
    @IBOutlet var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get all the moods
        moodObjects = manager.getMoodsFromStore()

        
        
        var cellNib = UINib(nibName: "MCMoodCellView", bundle: nil)
        historyTable.register(cellNib, forCellReuseIdentifier: "moodcell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moodObjects?.count > 0 {
            return (moodObjects?.count)!
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: "details") as! MoodDetailsViewController
        details.moodData = moodObjects?[indexPath.row]
        
        self.present(details, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MCMoodCellController = self.historyTable.dequeueReusableCell(withIdentifier: "moodcell") as! MCMoodCellController
        cell.moodName.text = moodObjects?[indexPath.row].moodName
        
        cell.moodDate.text = "2016"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86.0
    }
    
    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
