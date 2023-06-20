//
//  CancelRide.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/06/23.
//

import Foundation


struct CancelRideData: Codable {
    var id: Int
}

struct CancelRideResponse: Codable {
    let code: Int
    let message: String
}


extension CancelRideData {
    static var initialize = CancelRideData(id: 0)
}

extension CancelRideResponse {
    static var initialize = CancelRideResponse(code: 0, message: "")
}
