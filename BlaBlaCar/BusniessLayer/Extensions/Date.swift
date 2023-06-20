//
//  date.swift
//  BlaBlaCar
//
//  Created by Pragath on 03/06/23.
//

import Foundation

extension Date {
    
//    func timeFormat(time: String) -> String {
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            
//            let myTime = dateFormatter.date(from: time)
//            
//            guard let time = myTime else {
//                return ""
//            }
//            
//            dateFormatter.dateFormat = "HH:mm"
//            let tme = dateFormatter.string(from: time)
//            return tme
//        }
    
    func slashFormat(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let myTime = dateFormatter.date(from: time)
        
        guard let time = myTime else {
            return ""
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let tme = dateFormatter.string(from: time)
        return tme
    }
}
