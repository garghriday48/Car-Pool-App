//
//  PublishRideDatta.swift
//  BlaBlaCar
//
//  Created by Pragath on 03/06/23.
//

import Foundation


// MARK: - Welcome
struct PublishRideData: Codable {
    var publish: Publish
}

// MARK: - Publish
struct Publish: Codable {
    var source, destination: String
    var sourceLongitude, sourceLatitude, destinationLongitude, destinationLatitude: Double
    var passengersCount: String
    var addCity: String?
    var addCityLongitude, addCityLatitude: Double?
    var date, time, setPrice, aboutRide: String
    var vehicleID: Int
    var bookInstantly, midSeat: Bool?
    var estimateTime: String
    var selectRoute: SelectRoute

    enum CodingKeys: String, CodingKey {
        case source, destination
        case sourceLongitude = "source_longitude"
        case sourceLatitude = "source_latitude"
        case destinationLongitude = "destination_longitude"
        case destinationLatitude = "destination_latitude"
        case passengersCount = "passengers_count"
        case addCity = "add_city"
        case addCityLongitude = "add_city_longitude"
        case addCityLatitude = "add_city_latitude"
        case date, time
        case setPrice = "set_price"
        case aboutRide = "about_ride"
        case vehicleID = "vehicle_id"
        case bookInstantly = "book_instantly"
        case midSeat = "mid_seat"
        case estimateTime = "estimate_time"
        case selectRoute = "select_route"
    }
}

// MARK: - SelectRoute
struct SelectRoute: Codable {
}


extension PublishRideData {
    static var initialize = PublishRideData(publish: Publish(source: "", destination: "", sourceLongitude: 0.0, sourceLatitude: 0.0, destinationLongitude: 0.0, destinationLatitude: 0.0, passengersCount: "", addCity: nil, addCityLongitude: nil, addCityLatitude: nil, date: "", time: "", setPrice: "", aboutRide: "", vehicleID: Int(), bookInstantly: nil, midSeat: nil, estimateTime: "", selectRoute: SelectRoute()))
}
