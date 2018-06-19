import UIKit

//VC for adding new event
class newEventViewController: UIViewController {
    
    @IBOutlet var day: UILabel!
    
    @IBOutlet var monthYear: UILabel!
    
    //button for posting / putting an event
    @IBAction func addEvent() {
        //get times from datepickers
        startTime.datePickerMode = .time
        let d1 = startTime.date
        let startHourMinute = Calendar.current.dateComponents([.hour, .minute], from: d1)
        endTime.datePickerMode = .time
        let d2 = endTime.date
        let endHourMinute = Calendar.current.dateComponents([.hour, .minute], from: d2)
        
        //set values to event object
        var e = Event(title: eventTitle.text!,
                      description: eventDescription.text!,
                      year: String(selectedYear),
                      month: String(selectedMonth),
                      day: String(selectedDay),
                      start_hour: String(startHourMinute.hour!),
                      start_minute: String(startHourMinute.minute!),
                      end_hour: String(endHourMinute.hour!),
                      end_minute: String(endHourMinute.minute!),
                      user_id: "0",
                      id: "0")
        
        //if editing mode is true, put, else post
        if editingMode {
            editingMode = false
            e.id = editingEvent.id
            globalEvents.putEvent(event: e)
            for (idx, event) in globalEvents.all.enumerated() {
                if event.id! == editingEvent.id! {
                    globalEvents.all.remove(at: idx)
                }
            }
            globalEvents.setEventsForMonth(month: selectedMonth, year: selectedYear)
            globalEvents.setEventsForDay(day: selectedDay, month: selectedMonth, year: selectedYear)
        } else {
            globalEvents.postEvent(event: e)
        }
        globalEvents.all.append(e)
        globalEvents.selectedMonthEvents.append(e)
        globalEvents.selectedDayEvents.append(e)
        dismiss(animated: true, completion: nil)

    }

    //button for going back in the navigation
    @IBAction func goBack() {
        editingMode = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var eventTitle: UITextField!
    
    @IBOutlet var eventDescription: UITextField!
    
    @IBOutlet var startTime: UIDatePicker!
    
    @IBOutlet var endTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show what day, month, year it is
        day.text = "\(selectedDay)"
        monthYear.text = "\(helper.namesOfMonths[selectedMonth]!), \(selectedYear)"
        
        //if editing mode, prefill the form
        if editingMode {
            eventTitle.text = editingEvent.title!
            eventDescription.text = editingEvent.description!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            print("\(editingEvent.start_hour!):\(editingEvent.start_minute!)")
            let sTime = dateFormatter.date(from: "\(editingEvent.start_hour!):\(editingEvent.start_minute!)")
            startTime.date = sTime!
            let eTime = dateFormatter.date(from: "\(editingEvent.end_hour!):\(editingEvent.end_minute!)")
            endTime.date = eTime!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
