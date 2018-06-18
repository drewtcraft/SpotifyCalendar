//
//  dateClass.swift
//  spotifyCalendar
//
//  Created by Andrew Craft on 6/18/18.
//  Copyright © 2018 Andrew Craft. All rights reserved.
//

import Foundation

class Helper {
    
    let testEvent = Event(title: "helloooo",
                          description: "des",
                          year: "1980",
                          month: "234",
                          day: "234",
                          start_hour: "45",
                          start_minute: "345",
                          end_hour: "894",
                          end_minute: "498",
                          user_id: "5")
    
    let daysInMonths: [Int:Int] = [1:31, 2:28,3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31]
    
    let daysOfTheWeek: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    func getEventsForMonth(events: [Event], month: Int, year: Int) -> [Event] {
        var monthlyEvents: [Event] = []
        for event in events {
            if event.year?.toInt() == year && event.month?.toInt() == month {
                monthlyEvents.append(event)
            }
        }
        return monthlyEvents
    }
    
    func getCurrentMonthDay() -> (year: String, month: String, day: String){
        
        //get current date
        let date = Date()
        let cal = Calendar.current
        let currentYear = String(cal.component(.year, from: date))
        let currentMonth = String(cal.component(.month, from: date))
        let currentDay = String(cal.component(.day, from: date))
        
        return (year: currentYear, month: currentMonth, day: currentDay)
    }
    

}
