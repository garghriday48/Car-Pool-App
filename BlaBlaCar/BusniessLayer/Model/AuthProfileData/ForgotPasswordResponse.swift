//
//  ForgotPasswordResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 21/06/23.
//

import Foundation


struct ForgotPasswordResponse: Codable, Error {
    var code: Int
    var error: String?
    var message: String?
    var email: String?
}

extension ForgotPasswordResponse {
    static var initialize = ForgotPasswordResponse(code: 0, error: "", message: "", email: "")
}
