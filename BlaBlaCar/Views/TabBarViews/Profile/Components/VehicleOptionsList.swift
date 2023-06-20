//
//  VehicleOptionsList.swift
//  BlaBlaCar
//
//  Created by Pragath on 23/05/23.
//

import SwiftUI

struct VehicleOptionsList: View {
    
    @ObservedObject var profileVM: ProfileViewModel
    
    @Binding var toShowOptionsList: Bool
    //@Binding var vehicleOptionSelector: VehicleTextFieldType
    
    var body: some View {
        VStack{
            VStack{
                Capsule()
                    .frame(width: 40, height: 4)
                    .foregroundColor(Color(.systemGray3))
                HStack{
                    ZStack{
                        Button {
                            toShowOptionsList.toggle()
                        } label: {
                            Text(Constants.ButtonsTitle.close)
                                .font(.headline)
                                .foregroundColor(Color(.systemGray))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Text(profileVM.vehicleOptionSelector.rawValue)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .padding(.vertical)
            List {
                ForEach(profileVM.toGetVehicleOptionsList(), id: \.self){ item in
                    Button {
                        toShowOptionsList.toggle()
                        switch profileVM.vehicleOptionSelector {
                        case .country: profileVM.country = item
                        case .vehicleType: profileVM.vehicleType = item
                        case .color: profileVM.vehicleColor = item
                        case .year: profileVM.vehicleYear = item
                        case .name, .number, .brand: break
                        
                        }
                        
                    } label: {
                        Text(item)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
    }
}

struct VehicleOptionsList_Previews: PreviewProvider {
    static var previews: some View {
        VehicleOptionsList(profileVM: ProfileViewModel(), toShowOptionsList: .constant(false))
    }
}
