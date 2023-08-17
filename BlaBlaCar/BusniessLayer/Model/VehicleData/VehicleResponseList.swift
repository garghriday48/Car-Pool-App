//
//  VehicleResponseList.swift
//  BlaBlaCar
//
//  Created by Pragath on 01/06/23.
//

import Foundation


// MARK: - Welcome
struct VehicleResponseList: Codable {
    var code: Int
    var  data: [VehicleData]
}

extension VehicleResponseList{
     static var initialize = VehicleResponseList(code: 0, data: [VehicleData(id: 0, country: "", vehicleNumber: "", vehicleBrand: "", vehicleName: "", vehicleType: "", vehicleColor: "", vehicleModelYear: Int(), userID: Int(), createdAt: "", updatedAt: "")])
}
