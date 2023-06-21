//
//  VehicleListView.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import SwiftUI

struct VehicleEditView: View {
    
    @ObservedObject var vm: SignInSignUpViewModel
    @ObservedObject var profileVM: ProfileViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            HStack{
                BackButton(image: Constants.Images.cross) {
                    profileVM.isGoingBack = true
                }
                .font(.title)
                .bold()
                
                Text(profileVM.isAddingNewVehicle ? Constants.Headings.vehicleInfo : Constants.Headings.editVehicle)
                    .font(.title3)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 4, color: Color(.systemGray3))
            
            ScrollView{
                VStack{
                    
                    ForEach($profileVM.addingVehicleArray){$vehicle in
                        ProfileTextField(profileVM: profileVM, vm: vm,  textField: $vehicle.textField, vehicleTextFieldType: vehicle.textFieldType, heading: vehicle.heading, keyboardType: vehicle.keyboardType ?? .default, capitalizationType: vehicle.capitalizationType ?? .never)
                    }
                }
                .padding()
                Button {
                    if profileVM.isAddingNewVehicle {
                        profileVM.vehicleApiCall(method: .addVehicle, data: profileVM.makeDict(method: .addVehicle), httpMethod: .POST)
                        profileVM.vehicleListApiCall(method: .vehicleList, data: profileVM.makeDict(method: .vehicleList), httpMethod: .GET)
                    } else {
                        profileVM.vehicleApiCall(method: .updateVehicle, data: profileVM.makeDict(method: .updateVehicle), httpMethod: .PUT)
                        
                    }
                    profileVM.toDismissVehicleList = true
                } label: {
                    ButtonView(buttonName: Constants.ButtonsTitle.done, border: false)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color(Color.redColor))
                            )
                        .padding()
                }
                if !profileVM.isAddingNewVehicle {
                    Button {
                        profileVM.toDeleteVehicle.toggle()
                    } label: {
                        ButtonView(buttonName: Constants.ButtonsTitle.delete, border: true)
                            .padding(.horizontal)
                    }

                }
            }
            .sheet(isPresented: $profileVM.toShowVehicleOptionsList) {
                VehicleOptionsList(profileVM: profileVM, toShowOptionsList: $profileVM.toShowVehicleOptionsList)
            }
        }
        .onChange(of: profileVM.toDismiss, perform: { _ in
            if profileVM.toDismiss {
                self.dismiss()
            }
        })
        .onAppear{
            profileVM.addingVehicleArray = profileVM.vehicleOptionsArray
        }
        .scrollDismissesKeyboard(.immediately)
        .frame(maxWidth: .infinity , alignment: .leading)
        .navigationBarBackButtonHidden(true)
        .confirmationDialog(Constants.Headings.backAlertHeading, isPresented: $profileVM.isGoingBack, actions: {
            Button(Constants.ButtonsTitle.yes, role: .destructive) {
                self.dismiss()
  
            }
        }, message: {
            Text(Constants.Headings.backAlertHeading)
        })
        .confirmationDialog(Constants.Headings.deleteVehicleHeading, isPresented: $profileVM.toDeleteVehicle, actions: {
            Button(Constants.ButtonsTitle.yes, role: .destructive) {
                profileVM.vehicleApiCall(method: .deleteVehicle, data: profileVM.makeDict(method: .deleteVehicle), httpMethod: .DELETE)
                self.dismiss()
                profileVM.toDismissVehicleList = true
            }
            
        }, message: {
            Text(Constants.Headings.deleteVehicleHeading)
        })

    }
}

struct VehicleEditView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleEditView(vm: SignInSignUpViewModel(), profileVM: ProfileViewModel())
    }
}
