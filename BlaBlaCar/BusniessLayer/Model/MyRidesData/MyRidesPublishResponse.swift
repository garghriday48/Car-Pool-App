//
//  PublishListResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 14/06/23.
//

import Foundation


// MARK: Publish list response
struct PublishListResponse: Codable {
    var code: Int
    var data: [GetPublishResponse]
}

// MARK: Single Publish ride response
struct PublishResponseWithId: Codable {
    var code: Int
    var data: GetPublishResponse
    var reachTime: String?
    var passengers: [Passengers]?
    
    enum CodingKeys: String, CodingKey {
            case code, data
            case reachTime = "reach_time"
            case passengers
        }
}

// MARK: - Passengers
struct Passengers: Codable {
    let userID: Int
    let firstName, lastName, dob: String
    let phoneNumber: String?
    let phoneVerified: Bool?
    let image: String?
    let averageRating: String?
    let bio: String?
    let travelPreferences: String?
    let seats: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case dob
        case phoneNumber = "phone_number"
        case phoneVerified = "phone_verified"
        case image
        case averageRating = "average_rating"
        case bio
        case travelPreferences = "travel_preferences"
        case seats
    }
}

struct Empty: Codable {
}

// MARK: - GetPublishResponse
struct GetPublishResponse: Codable {
    let id: Int
    let source, destination: String
    var passengersCount: Int
    let addCity: String?
    let date: String
    let time: String?
    let setPrice: Double
    let aboutRide: String?
    let userID: Int
    let createdAt, updatedAt: String
    let sourceLatitude, sourceLongitude, destinationLatitude, destinationLongitude: Double
    let vehicleID: Int?
    let bookInstantly, midSeat: String?
    let status: String
    let estimateTime: String?
    let addCityLongitude, addCityLatitude: Double?

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
        case status
        case estimateTime = "estimate_time"
        case addCityLongitude = "add_city_longitude"
        case addCityLatitude = "add_city_latitude"
    }
}

extension PublishListResponse {
    static var initialize = PublishListResponse(code: Int(), data: [GetPublishResponse(id: 0, source: "", destination: "", passengersCount: 0, addCity: "", date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: "", midSeat: "", status: "", estimateTime: "", addCityLongitude: 0.0, addCityLatitude: 0.0)])
}

extension PublishResponseWithId {
    static var initialize = PublishResponseWithId(code: Int(), data: GetPublishResponse(id: 0, source: "gvewgewrgwe gheq rgh hger eghe heqgh gh er e erg ergew egege g rwegh rtghrt hrt", destination: "g erge grg er htymnynten tnetnetntbngntbtegbetnbtbntn bhtrt hnrhrtg", passengersCount: 0, addCity: "", date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: "", midSeat: "", status: "", estimateTime: "", addCityLongitude: 0.0, addCityLatitude: 0.0), reachTime: nil, passengers: [Passengers(userID: Int(), firstName: "", lastName: "", dob: "", phoneNumber: "", phoneVerified: false, image: "", averageRating: nil, bio: "", travelPreferences: nil, seats: 0)])
}
