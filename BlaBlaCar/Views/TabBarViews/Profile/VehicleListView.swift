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
                .font(.title2)
                
                Text(Constants.Headings.vehicles)
                    .font(.system(size: 18, design: .rounded))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 1, color: .gray.opacity(0.5))
                .padding(.bottom)
            ScrollView{
                ForEach(profileVM.vehicleResponseList.data){data in
                    Button {
                        profileVM.isVehicleViewSelected.toggle()
                        profileVM.toSetVehicleOptions(data: data)
                        profileVM.vehicleId = String(data.id)
                        profileVM.isAddingNewVehicle = false
                        profileVM.toDismiss = false
                    } label: {
                        SelectVehicleCellView(data: data)
                    }
                }

                Button(action: {
                    profileVM.isVehicleViewSelected.toggle()
                    profileVM.resetVehicleOptions()
                    profileVM.isAddingNewVehicle = true
                    profileVM.toDismiss = false
                }, label: {
                    ProfilePlusButton(image: Constants.Images.plusCircle, name: Constants.ButtonsTitle.addVehicle)
                        .foregroundColor(Color(Color.redColor))
                        .padding()
                })
            }
            .refreshable {
                profileVM.vehicleListApiCall(method: .vehicleList, data: profileVM.makeDict(method: .vehicleList), httpMethod: .GET)
            }
            .navigationDestination(isPresented: $profileVM.isVehicleViewSelected, destination: {
                VehicleEditView(vm: vm, profileVM: profileVM)
            })
        }
        .onAppear{
            profileVM.vehicleListApiCall(method: .vehicleList, data: profileVM.makeDict(method: .vehicleList), httpMethod: .GET)
        }
        .scrollDismissesKeyboard(.immediately)
        .navigationBarBackButtonHidden(true)
    }
}


struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView(vm: SignInSignUpViewModel(), profileVM: ProfileViewModel())
    }
}
