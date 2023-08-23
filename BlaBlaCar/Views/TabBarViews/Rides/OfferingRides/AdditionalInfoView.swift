//
//  AdditionalInfoView.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI

struct AdditionalInfoView: View {
    
    @ObservedObject var mapVM: MapViewModel
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    @EnvironmentObject var navigationVM: NavigationViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var vm: AuthViewModel
    @Environment (\.presentationMode) var presentationMode
    
    
    
    var body: some View {
        VStack{
            
            BackButton(image: Constants.Images.backArrow) {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
            
            VStack {
                Image(systemName: Constants.Images.checkmarkSeal)
                   .font(.system(size: 64))
                   .foregroundColor(Color(Color.redColor))
               
                Text(Constants.Headings.rideCreated)
                    .font(.system(size: 18, weight: .semibold ,design: .rounded))
                   .padding(.top, 10)
           }
            VStack(alignment: .leading) {
                Text(Constants.Description.addAboutRide)
                    .font(.headline)
                    .padding(.top, 44)
                    .padding(.bottom)
                Text(Constants.Description.forExample)
                    .font(.caption)
            
                    
                TextField(Constants.Description.type100, text: $carPoolVM.publishRideData.publish.aboutRide, axis: .vertical)
                    .lineLimit(8, reservesSpace: true)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 16 ,design: .rounded))
                }
            .padding()

            Spacer()
            
            /// button to publish ride and reset all the parameters to starting values.
            Button {
                if vm.userResponse.status.data?.phone_number == "" {
                    carPoolVM.noPhoneFound = true
                } else if !(vm.profileResponse.user?.phone_verified ?? false) {
                    carPoolVM.isPhoneVerified = true
                } else {
                    carPoolVM.publishRideApiCall(method: .publishRide, httpMethod: .POST)
                    carPoolVM.resetPublishRideValues()
                    carPoolVM.navigateToMapRoute = true
                    mapVM.mapView.removeAnnotations(mapVM.mapView.annotations)
                    mapVM.mapView.removeOverlays(mapVM.mapView.overlays)
                }
            } label: {
                ButtonView(buttonName: Constants.ButtonsTitle.publishRide, border: true)
            }
            .padding()

        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $carPoolVM.publishApiSuccess) {
            CompletedView(carPoolVM: carPoolVM, heading: Constants.Headings.ridePublished)
        }
        .navigationDestination(isPresented: $vm.goToEditProfileView, destination: {
            EditProfileView(vm: vm, profileVM: profileVM)
        })
        .fullScreenCover(isPresented: $vm.toDisplayPhoneVerification ){
            PhoneVerificationView(profileVM: profileVM)
        }
        .alert(Constants.ErrorBox.confirmPhone, isPresented: $carPoolVM.isPhoneVerified, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) { vm.toDisplayPhoneVerification = true }
        }, message: { Text(Constants.ErrorBox.confirmPhnMsg) })
        
        .alert(Constants.ErrorBox.addPhone, isPresented: $carPoolVM.noPhoneFound, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) { vm.goToEditProfileView = true }
        }, message: { Text(Constants.ErrorBox.addPhnMsg) })
        
    }
}

struct AdditionalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInfoView(mapVM: MapViewModel(), carPoolVM: CarPoolRidesViewModel())
    }
}
