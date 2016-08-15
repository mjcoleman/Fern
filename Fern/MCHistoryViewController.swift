//
//  MCHistoryViewController.swift
//  Fern
//
//  Created by Michael Coleman on 27/07/16.
//  Copyright © 2016 Michael Coleman. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class MCHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var moodObjects : [MCMood]?
    let manager : MCMoodStoreManager = MCMoodStoreManager()
    var uniqueDays : [String] = []
    
    
    
    @IBOutlet var historyTable: UITableView!
    @IBOutlet var mapView : MKMapView!
    @IBOutlet var viewSwitch : UISegmentedControl!
    @IBOutlet var moodCount : UILabel!
    
    @IBOutlet var calView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get all the moods
        moodObjects = manager.getMoodsFromStore(number: Constants.ALL_REQUESTS)
       
        //Reverse the array for looking at moods in reverse chronological order.
        moodObjects?.reverse()
        
        historyTable.backgroundColor = UIColor.clear
       
        moodCount.text = moodObjects?.count.description
        
        let cellNib = UINib(nibName: "MCMoodCellView", bundle: nil)
        historyTable.register(cellNib, forCellReuseIdentifier: "moodcell")
        
        let headerNib = UINib(nibName: "MCTableSectionHeader", bundle: nil)
        historyTable.register(headerNib, forHeaderFooterViewReuseIdentifier: "moodheader")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SwitchView(_ sender: AnyObject) {
        switch viewSwitch.selectedSegmentIndex{
        case 0:
            //Recent
          //  mapView.isHidden = true
            historyTable.isHidden = false
            break
        case 1:
            //Locations
           // mapView.isHidden = false
            //historyTable.isHidden = true
            break
        case 2:
            //Calendar
            historyTable.isHidden = true;
            calView.isHidden = false;
            break
        default:
            break
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //Find the unique days.
        var allDays = [String]()
        for i in moodObjects!{
            allDays.append(i.moodDate!.dateToString(hourmin: false, dayofweek: false, daymonth: true, year: true))
        }
        
        uniqueDays = Array(Set(allDays))
        return uniqueDays.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moodObjects?.count > 0 {
            return (moodObjects?.count)!
        }
        return 0
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: "details") as! MoodDetailsViewController
        details.moodData = moodObjects?[indexPath.row]
        
        self.present(details, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.historyTable.dequeueReusableHeaderFooterView(withIdentifier: "moodheader") as! MCTableSectionHeaderViewController
        if(uniqueDays[section] == NSDate().dateToString(hourmin: false, dayofweek: false, daymonth: true, year: true)){
            header.sectionLabel.text = "TODAY"
        }else{
            header.sectionLabel.text = uniqueDays[section].capitalized
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MCMoodCellController = self.historyTable.dequeueReusableCell(withIdentifier: "moodcell") as! MCMoodCellController
        let currentMood : MCMood = (moodObjects?[indexPath.row])!
        
        if(indexPath.row == 0){
            cell.firstInSection = true
        }
        
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        if(indexPath.row == totalRows-1){
            cell.lastInSection = true
        }
        
        
        
        //if(currentMood.moodDate?.dateToString(hourmin: false, dayofweek: false, daymonth: true, year: true) == indexPath.sec)
        cell.moodName.text = currentMood.moodName
        
        
        cell.moodDate.text = currentMood.moodDate?.dateToString(hourmin: true, dayofweek: false, daymonth: false, year: false)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
