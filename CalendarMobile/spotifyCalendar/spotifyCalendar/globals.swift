import Foundation
import UIKit

//extend string for easier conversion to int
extension String {
    func toInt() -> Int? {
        let num = NumberFormatter().number(from: self)
        let int = Int(truncating: num!)
        return int
    }
}

//instantiate events class
let globalEvents = Events()
//instantiate helper class
let helper = Helper()

//variable for what day of the week the month starts on (hard-coded to thursday for june)
var startingDay = 5

//variables for the selected day
var selectedDay = 0
var selectedYear: Int = 0
var selectedMonth: Int = 1

//variables for the current date
var currentYear: Int = 0
var currentMonth: Int = 1
var today: Int = 0

//variables for editing an event
var editingMode: Bool = false
var editingEvent: Event = helper.blankEvent
var editingIndex: Int = -1

//get screen size for sizing
let screenSize: CGRect = UIScreen.main.bounds


