import Foundation

//helper class - mostly date-related properties/methods
class Helper {
    
    //blank event for testing
    let blankEvent = Event(title: "",
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
    
    //days in each month
    let daysInMonths: [Int:Int] = [1:31, 2:28,3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31]
    
    //name of each month
    let namesOfMonths: [Int:String] = [1:"January", 2:"February", 3:"March", 4:"April", 5:"May", 6:"June", 7:"July", 8:"August", 9:"September", 10:"October", 11:"November", 12:"December"]
    
    let daysOfTheWeek: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    //retrieve current day, month, and year
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
