import Foundation



class Events: NSObject {
    
    var all: [Event] = []
    var selectedMonthEvents: [Event] = []
    var selectedDayEvents: [Event] = []
    
    func setEventsForDay(day: Int, month: Int, year: Int) {
        print("set day events")
        
        var dayEvents: [Event] = []
        for event in self.all {
            if event.year?.toInt() == year && event.month?.toInt() == month && event.day?.toInt() == day {
                dayEvents.append(event)
            }
        }
        self.selectedDayEvents.removeAll()
        self.selectedDayEvents = dayEvents
    }
    
    func setEventsForMonth(month: Int, year: Int){
        print("set month events")

        var monthlyEvents: [Event] = []
        for event in self.all {
            if event.year?.toInt() == year && event.month?.toInt() == month {
                monthlyEvents.append(event)
            }
        }
        self.selectedMonthEvents.removeAll()
        self.selectedMonthEvents = monthlyEvents
    }
    
    //method for turning event data into JSON for posting and putting
    func createJSON(event: Event) -> Data {
        //instantiate dictionary from Event class for converting to JSON
        var convertedDictionary: Dictionary<String, Any> = [:]
        
        //convert Event to dictionary
        convertedDictionary["title"] = event.title
        convertedDictionary["description"] = event.description
        convertedDictionary["year"] = event.year!.toInt()
        convertedDictionary["month"] = event.month!.toInt()
        convertedDictionary["day"] = event.day!.toInt()
        convertedDictionary["start_hour"] = event.start_hour!.toInt()
        convertedDictionary["start_minute"] = event.start_minute!.toInt()
        convertedDictionary["end_hour"] = event.end_hour!.toInt()
        convertedDictionary["end_minute"] = event.end_minute!.toInt()
        convertedDictionary["user_id"] = event.user_id
        convertedDictionary["id"] = event.id

        print(convertedDictionary)
        
        //turn converted dictionary into JSON data
        var jsonData: Data?
        do { jsonData = try JSONSerialization.data(withJSONObject: convertedDictionary, options: []) }
        catch { print("error serializing converted dictionary") }
        
        return jsonData!
    }
    
    //method for creating an event from JSON for get requests
    func createEventFromJSON(JSON:Any) -> Event{
        //instantiate blank event
        var event: Event = Event(title: "",
                                 description: "",
                                 year: "",
                                 month: "",
                                 day: "",
                                 start_hour: "",
                                 start_minute: "",
                                 end_hour: "",
                                 end_minute: "",
                                 user_id: "",
                                 id: "")
        
        do {
            //cast object as correct type
            let dict = JSON as? Dictionary<String, Any>
            
                //if cast succeeds, set up new event object
                event.title = dict?["title"] as? String
                event.title = event.title!
                event.description = dict?["description"] as! String
                event.description = event.description!
                if let year = dict?["year"] as? Float {
                    event.year = String(Int(year))
                }
                if let month = dict?["month"] as? Float {
                    event.month = String(month)
                }
                if let day = dict?["day"] as? Float {
                    event.day = String(day)
                }
                if let start_hour = dict?["start_hour"] as? Float {
                    event.start_hour = String(Int(start_hour))
                }
                if let start_minute = dict?["start_minute"] as? Float {
                    event.start_minute = String(Int(start_minute))
                }
                if let end_hour = dict?["end_hour"] as? Float {
                    event.end_hour = String(Int(end_hour))
                }
                if let end_minute = dict?["end_minute"] as? Float {
                    event.end_minute = String(Int(end_minute))
                }
            
                event.user_id = dict?["user_id"] as! String
                if let id = dict?["id"] as? Float {
                    event.id = String(id)
                }

        } catch { print("error converting JSON object") }
        
        return event
    }
    
    //CRUD functions
    func getEvents(){
        print("set all events")

        self.all.removeAll()
        let url = "http://localhost:5000/calendar/events"
        guard let requestUrl = URL(string: url) else { return }
        let request = URLRequest(url:requestUrl)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let events = data {
                    var json: [Any]
                    do {
                        json = try JSONSerialization.jsonObject(with: events, options: []) as! [Any]
                        for object in json {
                            self.all.append(self.createEventFromJSON(JSON: object))
                        }
                                           } catch {print("error")}
                }
            }
        task.resume()
    }
    
    func postEvent (event:Event){
        let url = "http://localhost:5000/calendar/events"
        guard let requestUrl = URL(string: url) else { return }
        var request = URLRequest(url:requestUrl)
        request.httpMethod = "POST"
        let body = createJSON(event: event)
        print(body)
        request.httpBody = body
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
            }
        }
        task.resume()
    }
    
    func putEvent (event:Event){
        let url = "http://localhost:5000/calendar/events/\(event.id!.toInt()!)"
        guard let requestUrl = URL(string: url) else { return }
        var request = URLRequest(url:requestUrl)
        request.httpMethod = "PUT"
        let body = createJSON(event: event)
        print("put", type(of: body))
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
            }
        }
        task.resume()
    }
    
    func deleteEvent (id:Int){
        print("id", id)
        let url = "http://localhost:5000/calendar/events/\(id)"
        guard let requestUrl = URL(string: url) else { return }
        var request = URLRequest(url:requestUrl)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
            }
        }
        task.resume()
    }
    
}
