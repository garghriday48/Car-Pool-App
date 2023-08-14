//
//  profileDetails.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/06/23.
//

import Foundation




struct ProfileDetails: Codable {
    var code: Int
    var message: String?
    var error: String?
    var errors: [String]?
    var user: DataResponse?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey{
        case code
        case message
        case error
        case errors
        case user
        case imageUrl = "image_url"
    }
}


extension ProfileDetails {
    static var initializeData = ProfileDetails(code: Int(), message: String(), user: DataResponse(id: Int(), email: "", created_at: "", updated_at: "", jti: "", first_name: "", last_name: "", dob: "", title: "", activation_digest: "", activated: false, activate_token: "", average_rating: "", otp: 0, phone_verified: false))
}
