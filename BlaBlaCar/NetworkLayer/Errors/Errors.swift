//
//  Errors.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import Foundation


enum AuthenticateError: LocalizedError{
    case badURL
    case badResponse
    case url(URLError?)
    case unknown
    case badConversion
    case noData
    case parsing
    case userExists
    case noUserExists
    case alreadyBooked
    
    // MARK: custom error description for errors
    var errorDescription: String?{
        switch self{
        case .badConversion:
            return "Cannot convert to json data"
        case .badURL:
            return "URL not found"
        case .badResponse:
            return "Something went wrong, Please check"
        case .url(let error):
            return "\(error?.localizedDescription ?? "")"
        case .unknown:
            return "Sorry, something went wrong."
        case .noData:
            return "No data found"
        case .parsing:
            return "Parsing Error \n Please check your data"
        case .userExists:
            return "User Already Exists,\n Log In to continue"
        case .noUserExists:
            return "No Such User Exists,\n Sign Up to continue"
        case .alreadyBooked:
            return "You have already booked this ride"
        }
    }
}
