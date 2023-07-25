//
//  MyRidesBookingResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/06/23.
//

import Foundation


// MARK: - Booking List response
struct BookingListResponse: Codable {
    let code: Int
    var rides: [RideElement]
}

// MARK: - RideElement
struct RideElement: Codable {
    let ride: GetPublishResponse
    let bookingID, seat: Int
    var status: String
    let reachTime: String?
    var totalPrice: Double

    enum CodingKeys: String, CodingKey {
        case ride
        case bookingID = "booking_id"
        case seat, status
        case reachTime = "reach_time"
        case totalPrice = "total_price"
    }
}


extension BookingListResponse {
    static var initialize = BookingListResponse(code: Int(), rides: [RideElement(ride: GetPublishResponse(id: 0, source: "", destination: "", passengersCount: 0, addCity: nil, date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: nil, midSeat: nil, status: "", estimateTime: "", addCityLongitude: nil, addCityLatitude: nil), bookingID: 0, seat: 0, status: "", reachTime: "", totalPrice: 0.0)])
}
