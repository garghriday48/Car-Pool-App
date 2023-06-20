//
//  RideSearchResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 02/06/23.
//

import Foundation

// MARK: - RideSearchResponse
struct RideSearchResponse: Codable {
    var code: Int
    var message: String?
    var data: [DataArray]
}

// MARK: - Data array
struct DataArray: Codable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(UUID())
    }
    static func == (lhs: DataArray, rhs: DataArray) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    let id: Int
    let name, reachTime: String
    let imageURL: URL?
    var averageRating: Double?
    let aboutRide: String?
    let publish: PublishResponse

    enum CodingKeys: String, CodingKey {
        case id, name
        case reachTime = "reach_time"
        case imageURL = "image_url"
        case averageRating = "average_rating"
        case aboutRide = "about_ride"
        case publish
    }
}

extension RideSearchResponse {
    static var initialize = RideSearchResponse(code: 0, data: [DataArray(id: 0, name: "", reachTime: "", imageURL: nil, averageRating: nil, aboutRide: "", publish: PublishResponse(id: 0, source: "", destination: "", passengersCount: 0, addCity: "", date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: "", midSeat: "", selectRoute: SelectRoute(), status: "", estimateTime: "", addCityLongitude: 0.0, addCityLatitude: 0.0, distance: nil, bearing: nil))])
}
