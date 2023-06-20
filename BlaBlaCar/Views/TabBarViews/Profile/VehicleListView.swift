//
//  VehicleListView.swift
//  BlaBlaCar
//
//  Created by Pragath on 23/05/23.
//

import SwiftUI

struct VehicleListView: View {
    
    @ObservedObject var vm: SignInSignUpViewModel
    @ObservedObject var profileVM: ProfileViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            HStack{
                BackButton(image: Constants.Images.backArrow) {
                    self.dismiss()
                }
                .font(.title)
                .bold()
                
                Text(Constants.Headings.vehicles)
                    .font(.title3)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 4, color: Color(.systemGray3))
                .padding(.bottom)
            ScrollView{
                ForEach(profileVM.vehicleResponseList.data){data in
                    Button {
                        profileVM.isVehicleViewSelected.toggle()
                        profileVM.toSetVehicleOptions(data: data)
                        profileVM.vehicleId = String(data.id)
                        
                    } label: {
                        SelectVehicleCellView(mainText: data.vehicleName, secondaryText: data.vehicleColor)
                            .foregroundColor(.primary)
                    }
                }

                Button(action: {
                    profileVM.isVehicleViewSelected.toggle()
                    profileVM.resetVehicleOptions()
                    profileVM.isAddingNewVehicle.toggle()
                }, label: {
                    ProfilePlusButton(image: Constants.Images.plusCircle, name: Constants.ButtonsTitle.addVehicle)
                        .foregroundColor(Color(Color.redColor))
                        .padding()
                })
            }
            .fullScreenCover(isPresented: $profileVM.isVehicleViewSelected) {
                VehicleEditView(vm: vm, profileVM: profileVM)
            }
        }
        .onChange(of: profileVM.toDismissVehicleList, perform: { _ in
            if profileVM.toDismissVehicleList {
                self.dismiss()
            }
        })
        .scrollDismissesKeyboard(.immediately)
        .navigationBarBackButtonHidden(true)
    }
}


struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView(vm: SignInSignUpViewModel(), profileVM: ProfileViewModel())
    }
}
