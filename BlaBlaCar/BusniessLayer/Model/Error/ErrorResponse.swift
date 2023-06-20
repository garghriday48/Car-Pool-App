//
//  ErrorResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 26/05/23.
//

import Foundation


struct ErrorResponse: Codable, Error {
    var status: ErrorStatus?
    var code: String?
    var error: String?
    
}

struct ErrorStatus: Codable, Error{
    var code: Int
    var message: String?
    var error: String?
    var errors: [String]?
}
