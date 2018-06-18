//
//  calendarEvents.swift
//  spotifyCalendar
//
//  Created by Andrew Craft on 6/16/18.
//  Copyright © 2018 Andrew Craft. All rights reserved.
//

import Foundation

extension String {
    func toInt() -> Int? {
        let num = NumberFormatter().number(from: self)
        let int = Int(truncating: num!)
        return int
    }
}

class Events: NSObject {
    
    var all: [Event] = []
    
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
        
        print(convertedDictionary)
        
        //turn converted dictionary into JSON data
        var jsonData: Data?
        do { jsonData = try JSONSerialization.data(withJSONObject: convertedDictionary, options: []) }
        catch { print("error serializing converted dictionary") }
        
        return jsonData!
    }
    
    //method for creating an event from JSON for get requests
    func createEventFromJSON(JSON:Data) -> Event{
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
                                 user_id: "")
        
        do {
            //convert JSON data to object
            let parsedJSON = try JSONSerialization.jsonObject(with: JSON, options: [])
        
            //cast object as correct type
            if let dict = parsedJSON as? [String:String] {
                //if cast succeeds, set up new event object
                event.title = dict["title"]
                event.description = dict["description"]
                event.year = dict["year"]
                event.month = dict["month"]
                event.day = dict["day"]
                event.start_hour = dict["start_hour"]
                event.start_minute = dict["start_minute"]
                event.end_hour = dict["end_hour"]
                event.end_minute = dict["end_minute"]
                event.user_id = dict["user_id"]
            }
        } catch { print("error converting JSON object") }
        
        return event
    }
    
    func getEvents(){
        
        let url = "http://localhost:5000/calendar/events"
        guard let requestUrl = URL(string: url) else { return }
        let request = URLRequest(url:requestUrl)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let events = data {
                    var json: Any
                    do {
                         json = try JSONSerialization.jsonObject(with: events, options: [])
                         print("event", json)
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
                self.getEvents()
            }
        }
        task.resume()
    }
    
    func putEvent (event:Event){
        let url = "http://localhost:5000/calendar/events"
        guard let requestUrl = URL(string: url) else { return }
        var request = URLRequest(url:requestUrl)
        request.httpMethod = "PUT"
        let body = createJSON(event: event)
        print(body)
        request.httpBody = body
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                self.getEvents()
            }
        }
        task.resume()
    }
    
    func deleteEvent (id:Int){
        let url = "http://localhost:5000/calendar/events"
        guard let requestUrl = URL(string: url) else { return }
        var request = URLRequest(url:requestUrl)
        request.httpMethod = "DELETE"
        var jsonData: Data?
        do { jsonData = try JSONSerialization.data(withJSONObject: id, options: []) }
        catch { print("error with converting delete id") }
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                self.getEvents()
            }
        }
        task.resume()
    }
    
}
