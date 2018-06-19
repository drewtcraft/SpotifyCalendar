import UIKit

//VC for listing all events (day view)
class eventsListTableViewController: UITableViewController {

    @IBOutlet var dayMonthYear: UILabel!
    
    //button for adding new event
    @IBAction func newEvent() {
        performSegue(withIdentifier: "newEvent", sender: nil)
    }
    
    //button for going back
    @IBAction func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show that day, month, year it is
        dayMonthYear.text = "Events on \(selectedDay) \(helper.namesOfMonths[selectedMonth]!), \(selectedYear)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //number of cells in tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalEvents.selectedDayEvents.count
    }
    
    //cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150.0;//Choose your custom row height
    }

    //cell data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! eventTableViewCell
        
        //get event from the day's events
        let e =  globalEvents.selectedDayEvents[indexPath.row]
        
        //set text
        cell.eventTitle.text = e.title!
        cell.eventDescription.text = e.description!
        cell.start.text = "begin: \(e.start_hour!):\(e.start_minute!)"
        cell.end.text = "end: \(e.end_hour!):\(e.end_minute!)"

        //pass event for use in delete and edit
        cell.cellEvent = e
        cell.index = indexPath.row

        return cell
    }
}
