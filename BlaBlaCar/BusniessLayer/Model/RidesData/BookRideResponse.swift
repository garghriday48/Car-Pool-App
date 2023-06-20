//
//  BookRideResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 03/06/23.
//

import Foundation

// MARK: bookRideResponse
struct BookRideResponse: Codable {
    var code: Int
    var error: String?
    var passenger: BookingDetails?
}

struct BookingDetails: Codable {
    var id: Int
    var userId: Int
    var publishId: Int
    let createdAt, updatedAt: String
    var price: Double
    var seats: Int
    var status: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case publishId = "publish_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case price
        case seats
        case status
    }
}

extension BookRideResponse {
    static let initialize = BookRideResponse(code: 0, passenger: BookingDetails(
        id: 0, userId: 0, publishId: 0, createdAt: "", updatedAt: "", price: 0, seats: 0, status: ""))
}
