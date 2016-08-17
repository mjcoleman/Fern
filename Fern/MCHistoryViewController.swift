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

class MCHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var moodObjects : [MCMood]?
    let manager : MCMoodStoreManager = MCMoodStoreManager()
    var uniqueDays : [String] = []
    
    typealias MonthTuple = (name: String, countDays: Int, startDay: Int)
    var montharray : [MonthTuple] = [(name: "August", countDays:31, startDay:1),(name: "July", countDays: 31, startDay:5)]
    
    
    
    
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
        
        let calCellNib = UINib(nibName: "MCCalCellCollectionViewCell", bundle: nil)
        calView.register(calCellNib, forCellWithReuseIdentifier: "calcell")
        
        let collectionHeaderNib = UINib(nibName: "MCCollectionHeaderView", bundle: nil)
        calView.register(collectionHeaderNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "collectionheader")
    
        var layout = calView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0)
        layout.headerReferenceSize = CGSize(width: 100, height: 50)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SwitchView(_ sender: AnyObject) {
        print("Called Switch View")
        switch viewSwitch.selectedSegmentIndex{
        case 0:
            //Recent
            mapView.isHidden = true
            calView.isHidden = true;
            historyTable.isHidden = false
            break
        case 1:
            //Locations
            mapView.isHidden = false
            //historyTable.isHidden = true
            break
        case 2:
            //Calendar
            mapView.isHidden = true
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
        if (moodObjects?.count)! > 0 {
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
            header.sectionLabel.text = uniqueDays[section].uppercased()
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

    
    
    // MARK :- CollectionView Functions
    // MARK: UICollectionViewDataSource
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return montharray.count
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return montharray[section].countDays + montharray[section].startDay
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MCCalCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "calcell", for: indexPath) as! MCCalCellCollectionViewCell

        cell.dateLabel.text =  String((indexPath.item+1) - montharray[indexPath.section].startDay)
        if(((indexPath.item+1) - montharray[indexPath.section].startDay) <= 0){
            cell.isSpacer = true;
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header : MCCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "collectionheader", for: indexPath) as! MCCollectionHeaderView
        
        header.headerLabel.text = (montharray[indexPath.section].name).uppercased() + " 2016"
        return header
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
  
     // Uncomment this method to specify if the specified item should be highlighted during tracking
      func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
    
    
    
     // Uncomment this method to specify if the specified item should be selected
      func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
    
    
    
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
      func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
      func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
      func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) {
     
     }
    

}
