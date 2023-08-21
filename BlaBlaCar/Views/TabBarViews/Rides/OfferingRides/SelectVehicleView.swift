//
//  SelectVehicleView.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI

struct SelectVehicleView: View {
    
    @EnvironmentObject var profileVM: ProfileViewModel
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    @Binding var toShowSelectVehicle: Bool
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            VStack{
                Capsule()
                    .frame(width: 40, height: 4)
                    .foregroundColor(Color(.systemGray3))
                HStack{
                    ZStack{
                        Button {
                            toShowSelectVehicle.toggle()
                        } label: {
                            Text(Constants.ButtonsTitle.close)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color(Color.redColor))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Text(Constants.Headings.selectVehicle)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                Divider()
            }
            .padding(.vertical)
            if profileVM.vehicleResponseList.data?.count != 0{
                ScrollView{
                    ForEach(profileVM.vehicleResponseList.data ?? []){data in
                        SelectVehicleCellView(data: data)
                            .onTapGesture {
                                carPoolVM.offerRideSelectorArray[0].text = data.vehicleBrand + " " + data.vehicleName
                                carPoolVM.publishRideData.publish.vehicleID = data.id
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
            } else {
                PlaceholderView(image: Constants.EmptyView.myRideImage, title: "No vehicle found", caption: "Add new vehicle to continue", needBackBtn: false , height: 100, width: 150)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
    }
}

struct SelectVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        SelectVehicleView(carPoolVM: CarPoolRidesViewModel(), toShowSelectVehicle: .constant(false))
    }
}
