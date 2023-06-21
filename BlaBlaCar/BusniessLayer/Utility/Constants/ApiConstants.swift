//
//  ApiConstants.swift
//  BlaBlaCar
//
//  Created by Pragath on 14/06/23.
//

import Foundation

extension Constants {
    
    struct Url {
        static var baseURL      = "https://791c-112-196-113-2.ngrok-free.app"
        static var signupKey    = "/users"
        static var signinKey    = "/users/sign_in"
        static var signoutKey   = "/users/sign_out"
        static var detailsKey   = "/users"
        static var getDetails   = "/users/"
        
        static var emailCheck   = "/email_check?email="
        static let addImage = "/user_images"
        static var updatePass = "/update_password"
        
        static var sendOtp = "/send_otp"
        static var verifyOtp = "/verify_otp"
        static var resetPassword = "/password_reset"
        
        static var addVehicle   = "/vehicles"
        static var updateVehicle = "/vehicles/"
        static var getVehicle = "/show_by_id/"
        
        static var publishRide  = "/publishes"
        static var searchRide   = "/search?"
        static var bookRide     = "/book_publish"
        
        static var publishById = "/publishes/"
        static var bookingList = "/booked_publishes"
        static var cancelRide  = "/cancel_booking"
        static var cancelPublishedRide = "/cancel_publish"
    }
    
    struct APIConstants {
        static var boundary         = "Boundary-\(NSUUID().uuidString)"
        static var user             = "user"
        static var application      = "application/json"
        static var content_type     = "Content-Type"
        static var authorization    = "Authorization"
        static var auth_token_key   = "authorization_token"
        static var multipart        = "multipart/form-data; boundary=\(boundary)"
        
        static var sourceLon = "source_longitude"
        static var sourceLat = "source_latitude"
        static var destLon = "destination_longitude"
        static var destLat = "destination_latitude"
        static var passCount = "passengers_count"
        static var date = "date"
        static var order = "order_by"
    }
    
    // MARK: - https header fields and values
    struct HTTPHeaderFieldAndValues {
        // values
        static let mutlpartFormData = "multipart/form-data"
        static let applicationJson  = "application/json"
    
        // headers
        static let contentType      = "Content-Type"
        static let authorization    = "Authorization"
    }
    
    struct StringForDataBody {
        
        static let lineBreak                        = "\r\n"
        static let boundary                         = UUID().uuidString
        
        static let multipartFormData                = "\(HTTPHeaderFieldAndValues.mutlpartFormData); boundary=\(boundary)"
        
        static let imageMimePng                    = "image/png"
        
        static let imageContentType                 = "Content-Type: %@\(lineBreak + lineBreak)"
        
        static let imageContentDisposition          = "Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\(lineBreak)"
        static let dataContentDisposition           = "Content-Disposition: form-data; name=\"%@\"\(lineBreak + lineBreak)"
        
        static let boudaryWithLineBreakTwoHyphens   = "--\(boundary + lineBreak)"
        static let boudaryWithLineBreakFourHyphens  = "--\(boundary)--\(lineBreak)"
    }
    
}
