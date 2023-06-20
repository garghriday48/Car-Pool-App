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
                                .font(.headline)
                                .foregroundColor(Color(.systemGray))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Text(Constants.Headings.selectVehicle)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                Divider()
            }
            .padding(.vertical)
            ScrollView{
                ForEach(profileVM.vehicleResponseList.data){data in
                    SelectVehicleCellView(mainText: data.vehicleName, secondaryText: data.vehicleColor)
                        .onTapGesture {
                            carPoolVM.offerRideSelectorArray[0].text = data.vehicleName
                            carPoolVM.publishRideData.publish.vehicleID = data.id
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            
//            HStack{
//                DividerCapsule(height: 1, color: Color(.systemGray5))
//                Text(Constants.Description.or)
//                DividerCapsule(height: 1, color: Color(.systemGray5))
//            }
//            HStack{
//                Button {
//
//                } label: {
//                    VStack(alignment: .leading, spacing: 8){
//                        HStack{
//                            Image(systemName: Constants.Images.plusCircle)
//                            Text(Constants.ButtonsTitle.addNewVehicle)
//                        }
//                        .padding()
//                        .bold()
//                        .foregroundColor(Color(Color.redColor))
//                        .font(.title2)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                }
//
//            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
    }
}

struct SelectVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        SelectVehicleView(carPoolVM: CarPoolRidesViewModel(), toShowSelectVehicle: .constant(false))
    }
}
