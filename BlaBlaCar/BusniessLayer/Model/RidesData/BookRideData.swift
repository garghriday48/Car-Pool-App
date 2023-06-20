//
//  BookRideData.swift
//  BlaBlaCar
//
//  Created by Pragath on 03/06/23.
//

import Foundation


struct BookRideData: Codable{
    
    var passenger: Passenger
}

struct Passenger: Codable {
    var publishId: Int
    var seats: Int
    
    enum CodingKeys: String, CodingKey {
        case publishId = "publish_id"
        case seats
    }
}

extension BookRideData {
    static var initialize = BookRideData(passenger: Passenger(publishId: 0, seats: 0))
}
