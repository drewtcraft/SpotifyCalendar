import UIKit

class calendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //variable for holding calendar cell information
    var calendarCells: [String] = []
    
    //set info for calendar cells and reload collection view
    func makeCalendar(){
        
        print("count", globalEvents.selectedMonthEvents.count)

        
        calendarCells.removeAll()
        //create days of the week labels
        for day in helper.daysOfTheWeek {
            calendarCells.append(day)
        }
        
        //instantiate counter variable for tracking days in month
        var internalCounter = 1
        //get days in selectedMonth
        let daysInSelectedMonth = helper.daysInMonths[selectedMonth]
        
        //42 == 6 rows of 7 cells - the maximum number of rows a month can occupy
        for i in 0..<42 {
            //if i is not a calendar day, append a blank string, otherwise add the date
            if i < startingDay || i > daysInSelectedMonth! + startingDay - 1 {
                calendarCells.append("")
            } else {
                calendarCells.append("\(internalCounter)")
                internalCounter += 1
            }
        }
        
        //set name of current month
        monthName.text = helper.namesOfMonths[selectedMonth]
        
        var indexPaths: [IndexPath] = []
        
        for i in 6 + startingDay...6 + startingDay + daysInSelectedMonth! {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        
        self.calendarCollection.reloadItems(at: indexPaths)
    }

    //attach calendar collection view
    @IBOutlet var calendarCollection: UICollectionView!
    
    //attach month label
    @IBOutlet var monthName: UILabel!
    
    //button for next month
    @IBAction func nextMonth() {
        
        //get day of the week of the first day of the month
        startingDay = (startingDay + helper.daysInMonths[selectedMonth]!) % 7
        
        selectedDay = 0
        globalEvents.selectedDayEvents.removeAll()
        
        //increase month by one unless it is dec
        if selectedMonth < 12 {
            selectedMonth += 1
        }
        else {
            selectedMonth = 1
            selectedYear += 1
        }
        //get events for month
        globalEvents.setEventsForMonth(month: selectedMonth, year: selectedYear)
        //reload calendar
        makeCalendar()
        
    }
    
    //button for previous month
    @IBAction func previousMonth() {
        
        //decrease month by one unless it is jan
        if selectedMonth == 1 {
            selectedMonth = 12
            selectedYear -= 1
        }
        else {
            selectedMonth -= 1
        }
        
        //get day of the week the month starts on
        startingDay = ((startingDay - helper.daysInMonths[selectedMonth]!) % 7) + 7
        if startingDay == 7 { startingDay = 0 }
        
        //get events for month
        globalEvents.setEventsForMonth(month: selectedMonth, year: selectedYear)

        //reload calendar
        makeCalendar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call API to get all events
        globalEvents.getEvents()
        
        //manually set size of collectionView cells
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width/7, height: screenSize.height/7)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        calendarCollection!.collectionViewLayout = layout
        
        //get current date
        let dateTuple = helper.getCurrentMonthDay()
        
        //set globals to current date
        selectedMonth = dateTuple.month.toInt()!
        selectedYear = dateTuple.year.toInt()!
        currentMonth = dateTuple.month.toInt()!
        currentYear = dateTuple.year.toInt()!
        today = dateTuple.day.toInt()!
        
        globalEvents.setEventsForMonth(month: selectedMonth, year: selectedYear)
        
        //set calendar
        makeCalendar()

    }
    
    //number of cells in collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarCells.count
    }
    
    //cell creation - calendarCells = datasource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! calendarCell
        
        //set cell text and some aesthetics
        cell.label.text = calendarCells[indexPath.row]
        cell.frame.size = CGSize(width: screenSize.width / 7, height: screenSize.height/7)
        cell.color.backgroundColor = UIColor.white
        cell.eventsText.frame.size = CGSize(width: cell.frame.width - 5, height: cell.frame.height)
        
        //get day of cell
        let day = indexPath.row - 6 - startingDay
        
        //set event titles in relevant cells
        if day > 0 && day <= helper.daysInMonths[selectedMonth]! {
            print(day)
            globalEvents.setEventsForDay(day: day, month: selectedMonth, year: selectedYear)
            let dayEvents = globalEvents.selectedDayEvents
            var eventTitles = ""
            
            for event in dayEvents {
                eventTitles += "\(event.title!) "
            }
            
            cell.eventsText.text = eventTitles
        }
        
        //if cell is the current date, highlight it
        if calendarCells[indexPath.row] == String(today) && selectedMonth == currentMonth && selectedYear == currentYear {
            cell.color.backgroundColor = UIColor.red
        }
        
        return cell
    }
    
    //set sizes of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //shorten first 7 since they are day labels
        if indexPath.row < 7 {
            return CGSize(width: screenSize.width / 7, height: 30)
        }
        return CGSize(width: screenSize.width / 7, height: screenSize.height/7)
    }
    
    //if cell is a date, segue to day view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row >= (7 + startingDay) && indexPath.row < (7 + startingDay + helper.daysInMonths[selectedMonth]!) {
            selectedDay = indexPath.row - 6 - startingDay
            
            globalEvents.setEventsForDay(day: selectedDay, month: selectedMonth, year: selectedYear)
            
            performSegue(withIdentifier: "dayView", sender: nil)
        }
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("this is being called")
        makeCalendar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

