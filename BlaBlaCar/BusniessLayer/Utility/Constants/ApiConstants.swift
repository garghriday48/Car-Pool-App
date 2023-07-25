//
//  ApiConstants.swift
//  BlaBlaCar
//
//  Created by Pragath on 14/06/23.
//

import Foundation

extension Constants {
    
    struct Url {
        static var baseURL      = "https://ea32-112-196-113-2.ngrok-free.app"
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
        
        static var messageList = "/chats/67/messages"
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
        static var sslError =  "An SSL error has occurred and a secure connection to the server cannot be made."
        static var wrongUrl = "A server with the specified hostname could not be found."
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
    
    struct ErrorBox {
        static var error = "Error"
        static var okay = "Okay"
        static var retry = "Retry"
        static var done = "Done"
        static var userExists = "User already exists \n Please Sign In to Continue"
        static var noUserExists = "No such user exists \n Register to continue"
        static var toLoginAgain = "You need to sign in or sign up before continuing."
        static var cancelRide = "Are you sure you want to cancel Ride booking?"
        static var cancelPublishedRide = "Are you sure you want to cancel your published ride?"
        static var rideUpdated = "Your ride has been successfully updated"
    }
    
    struct DictionaryForApiCall {
        static var email = "email"
        static var otp = "otp"
        static var user = "user"
        static var password = "password"
        static var firstName = "first_name"
        static var lastName = "last_name"
        static var dob = "dob"
        static var title = "title"
        static var phnNumber = "phone_number"
        static var bio = "bio"
        static var currentPass = "current_password"
        static var passConfirmation = "password_confirmation"
        
        static var publish = "publish"
        static var date = "date"
        static var time = "time"
        static var sourceLat = "source_latitude"
        static var sourceLong = "source_longitude"
        static var destLat = "destination_latitude"
        static var destLong = "destination_longitude"
        static var source = "source"
        static var destination = "destination"
        static var estimatedTime = "estimate_time"
        static var price = "set_price"
        static var count = "passengers_count"
        
        static var vehicle = "vehicle"
        static var country = "country"
        static var vehicleNum = "vehicle_number"
        static var vehicleBrand = "vehicle_brand"
        static var vehicleName = "vehicle_name"
        static var vehicleType = "vehicle_type"
        static var vehicleColor = "vehicle_color"
        static var vehicleYear = "vehicle_model_year"
         
    }
    
    struct TextfieldReuse {
        static var firstName = "First Name"
        static var lastName = "Last Name"
        static var gender = "Gender"
        static var dob = "Date of birth"
        static var email = "Email"
        static var phoneNum = "Phone number"
        
        static var country = "Country"
        static var name = "Name"
        static var brand = "Brand"
        static var number = "Number"
        static var type = "Type"
        static var color = "Color"
        static var year = "Year"
    }
}
