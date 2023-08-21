//
//  PhoneVerification.swift
//  BlaBlaCar
//
//  Created by Pragath on 18/08/23.
//

import Foundation




// MARK: - PhnEmailVerificationResponse
struct PhnEmailVerificationResponse: Codable, Error {
    let status: UserStatus
}

extension PhnEmailVerificationResponse {
    static var initialize = PhnEmailVerificationResponse(status: UserStatus(code: 0, message: "", error: ""))
}
//"Sent passccode"
//"Phone number verified!"
//{
//    "status": {
//        "code": 401,
//        "error": "Failed to verify passcode"
//    }
//}
//{
//    "status": {
//        "code": 200,
//        "message": "Activation email sent. Please check your email."
//    }
//}
