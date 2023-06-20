//
//  AddingVehicleData.swift
//  BlaBlaCar
//
//  Created by Pragath on 31/05/23.
//

import Foundation


struct AddingVehicleData: Codable {
    var vehicle: Vehicle
}

struct Vehicle: Codable {
    var country: String
    var number: String
    var brand: String
    var name: String
    var type: String
    var color: String
    var year: String
    
    enum CodingKeys: String, CodingKey {
        case country
        case number = "vehicle_number"
        case brand = "vehicle_brand"
        case name = "vehicle_name"
        case type = "vehicle_type"
        case color = "vehicle_color"
        case year = "vehicle_model_year"
    }
    
    
}

extension AddingVehicleData {
    static var initialize = AddingVehicleData(vehicle: Vehicle(country: "", number: "", brand: "", name: "", type: "", color: "", year: ""))
    
    
    
}
