//
//  RideSearchData.swift
//  BlaBlaCar
//
//  Created by Pragath on 02/06/23.
//

import Foundation


// MARK: - RideSearchData
struct RideSearchData: Codable {
    var sourceLongitude, sourceLatitude, destinationLongitude, destinationLatitude: Double
    var passCount: Int
    var date: String
    var order: String?

    enum CodingKeys: String, CodingKey {
        case sourceLongitude = "source_longitude"
        case sourceLatitude = "source_latitude"
        case destinationLongitude = "destination_longitude"
        case destinationLatitude = "destination_latitude"
        case passCount = "pass_count"
        case date
        case order = "order_by"
    }
}


extension RideSearchData {
    static var initialize = RideSearchData(sourceLongitude: 0.0, sourceLatitude: 0.0, destinationLongitude: 0.0, destinationLatitude: 0.0, passCount: 0, date: "", order: nil)
}
