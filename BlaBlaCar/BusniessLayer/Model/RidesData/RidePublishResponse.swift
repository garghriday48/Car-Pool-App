//
//  RidePublishResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 13/06/23.
//

import Foundation

// MARK: - PublishRideResponse
struct PublishRideResponse: Codable {
    let code: Int
    let publish: PublishResponse
}

// MARK: - PublishResponse
struct PublishResponse: Codable {
    let id: Int
    let source, destination: String
    let passengersCount: Int
    let addCity: String?
    let date: String
    let time: String
    let setPrice: Double
    let aboutRide: String?
    let userID: Int
    let createdAt, updatedAt: String
    let sourceLatitude, sourceLongitude, destinationLatitude, destinationLongitude: Double
    let vehicleID: Int
    let bookInstantly, midSeat: String?
    let selectRoute: SelectRoute?
    let status: String
    let estimateTime: String?
    let addCityLongitude, addCityLatitude: Double?
    let distance: Double?
    let bearing: String?

    enum CodingKeys: String, CodingKey {
        case id, source, destination
        case passengersCount = "passengers_count"
        case addCity = "add_city"
        case date, time
        case setPrice = "set_price"
        case aboutRide = "about_ride"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case sourceLatitude = "source_latitude"
        case sourceLongitude = "source_longitude"
        case destinationLatitude = "destination_latitude"
        case destinationLongitude = "destination_longitude"
        case vehicleID = "vehicle_id"
        case bookInstantly = "book_instantly"
        case midSeat = "mid_seat"
        case selectRoute = "select_route"
        case status
        case estimateTime = "estimate_time"
        case addCityLongitude = "add_city_longitude"
        case addCityLatitude = "add_city_latitude"
        case distance
        case bearing
    }
}

extension PublishRideResponse {
    static var initialize = PublishRideResponse(code: Int(), publish: PublishResponse.initialize)
}

extension PublishResponse {
    static var initialize = PublishResponse(id: 0, source: "", destination: "", passengersCount: 0, addCity: "", date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: "", midSeat: "", selectRoute: SelectRoute(), status: "", estimateTime: "", addCityLongitude: 0.0, addCityLatitude: 0.0, distance: nil, bearing: nil)
}
