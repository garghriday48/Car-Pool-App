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
                .font(.title2)
                
                Text(profileVM.isAddingNewVehicle ? Constants.Headings.vehicleInfo : Constants.Headings.editVehicle)
                    .font(.system(size: 18, design: .rounded))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 1, color: .gray.opacity(0.5))
            
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
                        
                    } else if !profileVM.isAddingNewVehicle {
                        profileVM.vehicleApiCall(method: .updateVehicle, data: profileVM.makeDict(method: .updateVehicle), httpMethod: .PUT)
                    }
                    
                } label: {
                    ButtonView(buttonName: Constants.ButtonsTitle.done, border: false)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(Color.redColor))
                            )
                        .padding(.horizontal)
                        .padding(.trailing, 8)
                }
                
                if !profileVM.isAddingNewVehicle {
                    Button {
                        profileVM.toDeleteVehicle.toggle()
                    } label: {
                        ButtonView(buttonName: Constants.ButtonsTitle.delete, border: true)
                            .padding(.horizontal)
                            .padding(.trailing, 8)
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
