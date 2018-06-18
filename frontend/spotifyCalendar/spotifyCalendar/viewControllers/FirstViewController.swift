//
//  FirstViewController.swift
//  spotifyCalendar
//
//  Created by Andrew Craft on 6/16/18.
//  Copyright © 2018 Andrew Craft. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    let globalEvents = Events()
    let helper = Helper()
    

    
    var selectedYear = 0
    var selectedMonth = 0
    var today = 0

    
    //get screen size for sizing collection cells
    let screenSize: CGRect = UIScreen.main.bounds

    //attach calendar collection view
    @IBOutlet var calendarCollection: UICollectionView!
    
    
    
    @IBAction func nextMonth() {
        //increase month by one unless it is dec
        selectedMonth = selectedMonth < 13 ? selectedMonth += 1 : selectedMonth = 1
        
    }
    
    @IBAction func previousMonth() {
    }
    
    var calendarCells: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //import helper class
        
        //call API to get all events
        globalEvents.getEvents()
        
        //manually set size of collectionView cells
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenSize.width/7, height: screenSize.height/10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        calendarCollection!.collectionViewLayout = layout
        
        //get current date
        let dateTuple = helper.getCurrentMonthDay()
        let currentYear = dateTuple.year
        let currentMonth = dateTuple.month
        let currentDay = dateTuple.day
        today = currentDay.toInt()!

        
        //set globals
        selectedMonth = currentMonth.toInt()!
        selectedYear = currentYear.toInt()!
        
        //get events for current month
        let eventsForMonth = helper.getEventsForMonth(events: globalEvents.all, month: selectedMonth, year: selectedYear)
        
        //create days of the week labels
        let daysOfTheWeek: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        for day in daysOfTheWeek {
            calendarCells.append(day)
        }
        
        let startingDay = 5
        var internalCounter = 1
        let daysInSelectedMonth = helper.daysInMonths[selectedMonth]
        
        for i in 0..<42 {
            if i < startingDay || i > daysInSelectedMonth! + startingDay {
                calendarCells.append("")
            } else {
                calendarCells.append("\(internalCounter)") 
                internalCounter += 1
            }
        }
        
        self.calendarCollection.reloadSections(IndexSet(integer: 0))

        
        
      

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! calendarCell
        cell.label.text = calendarCells[indexPath.row]
        cell.frame.size = CGSize(width: screenSize.width / 7, height: 150)
        if calendarCells[indexPath.row] == String(today) {
            cell.color.backgroundColor = UIColor.red
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //shorten first 7 since they are day labels
        if indexPath.row < 7 {
            return CGSize(width: screenSize.width / 7, height: 30)
        }
        return CGSize(width: screenSize.width / 7, height: screenSize.height/10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row > 7 {
            return
        }
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

