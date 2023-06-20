//
//  UserResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 31/05/23.
//

import Foundation

struct UserResponse: Codable {
    var status: UserStatus
}

struct UserStatus: Codable{
    var code: Int
    var message: String?
    var error: String?
    var errors: [String]?
    var data: Dataresponse?
    var imageUrl: URL?
    
    enum CodingKeys: String, CodingKey{
        case code
        case message
        case error
        case errors
        case data
        case imageUrl = "image_url"
    }
}

struct Dataresponse: Codable{
    var id: Int
    var email : String
    var created_at: String
    var updated_at: String
    var jti: String
    var first_name: String
    var last_name: String
    var dob: String
    var title: String
    var phone_number: String?
    var bio: String?
    var travel_preferences: String?
    var postal_address: String?
    var activation_digest: String
    var activated : Bool?
    var activated_at : String?
    var activate_token: String
    var session_key: String?
    var average_rating: String?
    var otp: Int
    var phone_verified: Bool?
}

extension UserResponse {
    static var initializeData = UserResponse(status: UserStatus(code: Int(), message: String(), error: nil, errors: nil, data: Dataresponse(id: Int(), email: "", created_at: "", updated_at: "", jti: "", first_name: "", last_name: "", dob: "", title: "", activation_digest: "", activated: false, activate_token: "", average_rating: "", otp: 0, phone_verified: false)))
}
