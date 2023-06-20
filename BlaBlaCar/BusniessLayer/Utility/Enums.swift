//
//  Enums.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import Foundation
import SwiftUI


enum SignUpViewsEnum: Float {
    case emailPasswordView = 25
    case fullNameView = 50
    case dobView = 75
    case genderView = 100
}


enum ViewID {
    case OnboardingView
    case MainSigninSignupView
    case SignupPage
    case LoginPage
    case TabBarPage
    case carPoolPublish
    case carPoolBook
}

/// enum for checking http method for api request
enum HttpMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}


enum ApiMethods: String {
    case signIn = "POST"
    case signUp = "POST "
    case signOut = "DELETE"
    case emailCheck = "GET"
    case profileUpdate = "PUT"
    case bioUpdate = "PUT "
    case addImage = "PUT  "
    case getDetails = "GET "
    //case addVehicle = "POST  "
}

enum ApiVehicleMethods: String{
    case addVehicle = "POST"
    case updateVehicle = "PUT"
    case vehicleList = "GET"
    case deleteVehicle = "DELETE"
    case getVehicle = "GET "

}

enum ApiRideMethods: String {
    case publishRide = "POST"
    case searchRide = "GET"
    case bookRide = "POST "
    case searchRideByOrder = "GET "
}

enum ApiMyRidesMethods: String {
    case publishList = "GET"
    case publishById = "GET "
    case bookingList = " GET"
    case cancelRide = "POST"
    case cancelPublishedRide = "POST "
    case updatePublishedRide = "PUT"
}

enum TabViews: RawRepresentable, CaseIterable {
    case carPool
    case myRides
    case messages
    case profile

    var rawValue: (text: String, image: String) {
        switch self {
        case .carPool: return(text: "CarPool", image: "quote.opening")
        case .myRides: return(text: "My Rides", image: "timer")
        case .messages: return(text: "Messages", image: "message.fill")
        case .profile: return(text: "Profile", image: "person.circle")
        }
    }

    init?(rawValue: (text: String, image: String)) {
        switch rawValue {
        case (text: "CarPool", image: "quote.opening"): self = .carPool
        case (text: "My Rides", image: "timer"): self = .myRides
        case (text: "Messages", image: "message.fill"): self = .messages
        case (text: "Profile", image: "person.circle"): self = .profile
        default: return nil
        }
    }
}

enum RideBookedType: String {
    
    case CONFIRM = "confirm booking"
    case CANCEL = "cancel booking"
}

enum RidePublishedType: String {
    case confirm = "confirmed"
    case pending = "pending"
    case cancel = "cancelled"
}



enum EditPublicationTypes: String, CaseIterable {
    case itineraryDetails = "Itinerary Details"
    case price = "Price"
    case seats = "Seats"
}

enum OfferRideSelector: Int {
    case SelectVehicle = 0
    case AvailableSeats = 1
    case PricePerSeat = 2
}

enum RideMethods: String, CaseIterable {
    case bookingRide = "Book a ride"
    case offeringRide = "Offer a ride"
}

enum RideType: String, CaseIterable {
    case booked = "Booked"
    case published = "Published"
}


enum ProfileOptions: Int,CaseIterable {
    case editProfile = 0
    case accountSettings = 1
    case vehicle = 2
}

enum TextFieldType {
    case firstName
    case secondName
    case gender
    case dob
    case email
    case phnNum
}

enum VehicleTextFieldType: String {
    case name
    case number
    case brand
    case country = "Countries"
    case year = "Year"
    case vehicleType = "Type of vehicle"
    case color = "Color"
}

