//
//  Shared.swift
//  BlaBlaCar
//
//  Created by Pragath on 14/06/23.
//

import Foundation

 
struct DateTimeFormat {
    static var shared = DateTimeFormat()
    
    private init() {}
    
    /// function to convert date from a specific format to other useful format for time
    /// - Parameter date: time of type string
    /// - Returns: returns time of type string in different format
    func timeFormat(date: String, is24hrs: Bool, toNotReduce:Bool) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            if let date = dateFormatter.date(from: date) {
                let outputDateFormatter = DateFormatter()
                if is24hrs {
                    outputDateFormatter.dateFormat = "HH:mm"
                } else {
                    outputDateFormatter.dateFormat = "hh:mm a"
                }
                if toNotReduce {
                    return outputDateFormatter.string(from: date)
                } else {
                    guard let dateMinus6Hours = Calendar.current.date(byAdding: .hour, value: -5, to: date) else {return ""}
                    guard let dateMinus30Mins = Calendar.current.date(byAdding: .minute, value: -30, to: dateMinus6Hours) else {return ""}
                    return outputDateFormatter.string(from: dateMinus30Mins)
                    
                }
            } else {
                return "Invalid date format"
            }
        }
    
//    /// function to convert date from a specific format to other useful format for time
//    /// - Parameter date: time of type string
//    /// - Returns: returns time of type string in different format
//    func messageTimeFormat(date: String, is24hrs: Bool) -> String {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//
//            if let date = dateFormatter.date(from: date) {
//                let outputDateFormatter = DateFormatter()
//                if is24hrs {
//                    outputDateFormatter.dateFormat = "HH:mm"
//                } else {
//                    outputDateFormatter.dateFormat = "hh:mm a"
//                }
////                guard let dateMinus6Hours = Calendar.current.date(byAdding: .hour, value: +5, to: date) else {return ""}
////                guard let dateMinus30Mins = Calendar.current.date(byAdding: .minute, value: +30, to: dateMinus6Hours) else {return ""}
//                return outputDateFormatter.string(from: date)
//            } else {
//                return "Invalid date format"
//            }
//        }
    
    /// function to convert date from a specific format to other useful format
    /// - Parameter date: date of type string
    /// - Returns: returns date of type string in different format
    func dateFromApiFormat(date: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            if let date = dateFormatter.date(from: date) {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "yyyy-MM-dd"
                //guard let dateMinus6Hours = Calendar.current.date(byAdding: .hour, value: -5, to: date) else {return ""}
                //guard let dateMinus30Mins = Calendar.current.date(byAdding: .minute, value: -30, to: dateMinus6Hours) else {return ""}
                return outputDateFormatter.string(from: date)
            } else {
                return "Invalid date format"
            }
        }
    
    
    /// function to convert date in string to Date()
    /// - Parameter time: date of type string
    /// - Returns: returns date 
    func stringToTime(time: String) -> Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            
        return dateFormatter.date(from: time) ?? Date()
        }
    
    /// function to convert time in string to Date()
    /// - Parameter date: date of type string
    /// - Returns: returns date
    func stringToDate(date: String) -> Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
        return dateFormatter.date(from: date) ?? Date()
        }
    
    
    func dateFormat(date: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date = dateFormatter.date(from: date) {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "EEEE, MMMM dd YYYY"
                return outputDateFormatter.string(from: date)
            } else {
                return "Invalid date format"
            }
        }
    
    /// function to convert Int( seconds) to date of type string
    /// - Parameter seconds: In Int
    /// - Returns: returns date of type string
    func toConvertDate(seconds: Int) -> String {
        let hours =  seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        return "\(hours):\(minutes):\(seconds)"
    }
    
    /// method to convert int value to year string
    /// - Parameter year: value of year in int
    /// - Returns: value of year in string
    static func yearString(at year: Int) -> String {
        let selectedYear = year
        let dateFormatter = DateFormatter()
        return dateFormatter.string(for: selectedYear) ?? selectedYear.description
    }
}

struct Age {
    static var shared = Age()
    
    private init() {}
    
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
}
