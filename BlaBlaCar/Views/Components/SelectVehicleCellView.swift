//
//  SelectVehicleCellView.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI

struct SelectVehicleCellView: View {
    
    var data: VehicleData
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(data.vehicleName) | \(data.vehicleBrand)")
                .font(.system(size: 16))
            Text("\(data.vehicleType) | \(data.vehicleColor) | \(DateTimeFormat.yearString(at: data.vehicleModelYear))")
                .font(.system(size: 14, weight: .light))
            Text("\(data.vehicleNumber)")
                .font(.system(size: 14, weight: .light))
            DividerCapsule(height: 1, color: .gray.opacity(0.3))
        }
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct SelectVehicleCellView_Previews: PreviewProvider {
    static var previews: some View {
        SelectVehicleCellView(data: VehicleData(id: 0, country: "hr", vehicleNumber: "1234", vehicleBrand: "hgrtwh", vehicleName: "jtrwhjw", vehicleType: "jrtwh", vehicleColor: "yejty", vehicleModelYear: 2012, userID: 0, createdAt: "", updatedAt: ""))
    }
}
