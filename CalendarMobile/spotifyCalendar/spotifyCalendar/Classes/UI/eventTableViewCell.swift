import UIKit

//tableview cell for day view
class eventTableViewCell: UITableViewCell {
    
    
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventDescription: UILabel!
    @IBOutlet var start: UILabel!
    @IBOutlet var end: UILabel!

    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    //button for deleting event
    @IBAction func deleteEvent() {
        
        //delete event
        globalEvents.deleteEvent(id: cellEvent.id!.toInt()!)
        for (idx, event) in globalEvents.all.enumerated() {
            if event.id! == cellEvent.id! {
                globalEvents.all.remove(at: idx)
            }
        }
        globalEvents.setEventsForMonth(month: selectedMonth, year: selectedYear)
        globalEvents.setEventsForDay(day: selectedDay, month: selectedMonth, year: selectedYear)
        eventTitle.text = "Deleted"
        eventDescription.removeFromSuperview()
        start.removeFromSuperview()
        end.removeFromSuperview()
        deleteButton.removeFromSuperview()
        editButton.removeFromSuperview()
        
        
    }
    
    //button for entering edit mode
    @IBAction func editEvent() {
        editingMode = true
        editingEvent = cellEvent
        editingIndex = index

    }
    
    var cellEvent: Event = helper.blankEvent
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
