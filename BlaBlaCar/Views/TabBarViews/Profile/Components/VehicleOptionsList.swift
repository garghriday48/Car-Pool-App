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
    @State var searchText = ""
    
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
                NavigationStack{
                List {
                    ForEach(searchResults, id: \.self){ item in
                        Button {
                            toShowOptionsList.toggle()
                            switch profileVM.vehicleOptionSelector {
                            case .country: profileVM.country = item
                            case .vehicleType: profileVM.vehicleType = item
                            case .color: profileVM.vehicleColor = item.capitalized
                            case .year: profileVM.vehicleYear = item
                            case .name, .number, .brand: break
                                
                            }
                            
                        } label: {
                            Text(item)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .searchable(text: $searchText)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
        }
    }
    
    //Show the entire list if search field is blank else show compatible items
    var searchResults: [String] {
        if searchText.isEmpty {
            return profileVM.toGetVehicleOptionsList(method: profileVM.vehicleOptionSelector)
        } else {
            return profileVM.toGetVehicleOptionsList(method: profileVM.vehicleOptionSelector).filter { $0.contains(searchText) }
        }
    }
}

struct VehicleOptionsList_Previews: PreviewProvider {
    static var previews: some View {
        VehicleOptionsList(profileVM: ProfileViewModel(), toShowOptionsList: .constant(false))
    }
}
