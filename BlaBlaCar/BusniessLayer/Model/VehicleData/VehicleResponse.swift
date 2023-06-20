//
//  VehicleResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 31/05/23.
//

import Foundation

// MARK: - VehicleResponse
struct VehicleResponse: Codable {
    let status: VehicleStatus
}

// MARK: - Status
struct VehicleStatus: Codable {
    let code: Int
    let message: String?
    let data: VehicleData?
    //let data: [VehicleData]?
    

}

// MARK: - DataClass
struct VehicleData: Codable, Identifiable {
    let id: Int
    let country, vehicleNumber, vehicleBrand, vehicleName: String
    let vehicleType, vehicleColor: String
    let vehicleModelYear, userID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, country
        case vehicleNumber = "vehicle_number"
        case vehicleBrand = "vehicle_brand"
        case vehicleName = "vehicle_name"
        case vehicleType = "vehicle_type"
        case vehicleColor = "vehicle_color"
        case vehicleModelYear = "vehicle_model_year"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension VehicleResponse {
    static var initialize = VehicleResponse(status: VehicleStatus(code: Int(), message: "", data: VehicleData(id: Int(), country: "", vehicleNumber: "", vehicleBrand: "", vehicleName: "", vehicleType: "", vehicleColor: "", vehicleModelYear: Int(), userID: Int(), createdAt: "", updatedAt: "")))
}

extension VehicleData {
    static var initialize = VehicleData(id: Int(), country: "", vehicleNumber: "", vehicleBrand: "", vehicleName: "", vehicleType: "", vehicleColor: "", vehicleModelYear: Int(), userID: Int(), createdAt: "", updatedAt: "")
}
