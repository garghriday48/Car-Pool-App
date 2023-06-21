//
//  ProfileView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var vm: SignInSignUpViewModel
    @ObservedObject var profileVM: ProfileViewModel
    
    var body: some View {
        //NavigationStack{
            ZStack(alignment: .top){
                VStack{
                    HStack{
                        Text(Constants.Headings.profile)
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity ,alignment: .topLeading)
                        
                        Spacer()
                        Button {
                            
                        } label: {
                            Text(Constants.ButtonsTitle.helpSupport)
                                .font(.headline)
                                .foregroundColor(Color(Color.redColor))
                        }
                        
                    }
                    .padding()
                    DividerCapsule(height: 4, color: Color(.systemGray3))
                        .padding(.bottom)
                    ScrollView{
                        VStack{
                            AsyncImage(url: vm.profileResponse.imageUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        if vm.profileResponse.imageUrl == nil {
                                            Image(Constants.Images.person)
                                                .resizable()
                                                .scaledToFill()
                                        } else {
                                            ZStack {
                                                Color.gray.opacity(0.1)
                                                ProgressView()
                                            }
                                        }
                                    }
                                    
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            
                            (Text(vm.userData?.status.data?.first_name ?? "No") + Text(" ") +
                             Text(vm.userData?.status.data?.last_name ?? "Name"))
                            .font(.title3)
                            .bold()
                            .padding(.bottom,50)
                            
                            DividerCapsule(height: 2, color: Color(.systemGray3))
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text(Constants.Headings.verifyProfile)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.bottom)
                                ForEach(DataArrays.profilePlusButtonArray, id: \.self){button in
                                    
                                    Button {
                                        profileVM.toDisplayPhoneVerification.toggle()
                                    } label: {
                                        ProfilePlusButton(image: button[0], name: button[1])
                                    }
                                    .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            DividerCapsule(height: 2, color: Color(.systemGray3))
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text(Constants.Headings.aboutYou)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.bottom)
                                NavigationLink {
                                    BioView(vm: vm, profileVM: profileVM)
                                } label: {
                                    if vm.userData?.status.data?.bio == nil {
                                        ProfilePlusButton(image: Constants.Images.plusCircle, name: Constants.ButtonsTitle.addMiniBio)
                                    } else {
                                        HStack{
                                            Image(systemName: Constants.Images.checkmarkFilled)
                                            Text(vm.userData?.status.data?.bio ?? "")
                                                .foregroundColor(.gray)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .font(.title3)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .foregroundColor(.blue)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            DividerCapsule(height: 2, color: Color(.systemGray3))
                            
                            ForEach(0..<3, id: \.self){option in
                                NavigationLink {
                                    switch ProfileOptions(rawValue: option){
                                    case .editProfile: EditProfileView(vm: vm, profileVM: profileVM)
                                    case .accountSettings : AccountSettingsView(vm:vm, profileVM: profileVM)
                                    case .vehicle :
                                        VehicleListView(vm: vm, profileVM: profileVM)
                                        
                                    case .none:
                                        EmptyView()
                                    }
                                } label: {
                                    ProfileOptionsCellView(mainText: DataArrays.profileOptionsArray[option][0], secondaryText: DataArrays.profileOptionsArray[option][1])
                                }
                            }
                            Button {
                                vm.apiCall(method: .signOut, httpMethod: .GET, data: vm.getData(method: .signOut))
                            } label: {
                                Text(Constants.ButtonsTitle.logOut)
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(Color(Color.redColor))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
            }
        
            .alert(Constants.ErrorBox.error, isPresented: $vm.hasResponseError, actions: {
                Button(Constants.ErrorBox.okay, role: .cancel) {
                }
            }, message: {
                Text(vm.errorMessage1)
            })

            .alert(Constants.ErrorBox.error, isPresented: $vm.hasError, actions: {
                Button(Constants.ErrorBox.okay, role: .cancel) {
                }
            }, message: {
                Text(vm.errorMessage?.errorDescription ?? "")
            })
            .fullScreenCover(isPresented: $profileVM.toDisplayPhoneVerification, content: {
                PhoneVerificationView(profileVM: profileVM)
            })
            .onAppear {
                vm.userId = vm.userData?.status.data?.id ?? 0
                vm.getProfileApiCall(method: .getDetails, httpMethod: .GET, data: [:])
                profileVM.vehicleListArray = profileVM.vehicleResponseList.data
                profileVM.isVehicleViewSelected = false
                profileVM.toDismissVehicleList = false
                profileVM.isAddingNewVehicle = false
                profileVM.toDeleteVehicle = false
            }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: SignInSignUpViewModel(), profileVM: ProfileViewModel())
    }
}
