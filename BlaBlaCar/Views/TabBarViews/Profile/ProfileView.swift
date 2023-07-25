//
//  ProfileView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct ProfileView: View {
    
    @ObservedObject var vm: SignInSignUpViewModel
    @ObservedObject var profileVM: ProfileViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    @State var photosPicker: [PhotosPickerItem] = []
    
    var body: some View {
            ZStack(alignment: .top){
                VStack{
                    HStack{
                        Text(Constants.Headings.profile)
                            .font(.system(size: 24, design: .rounded))
                            .bold()
                            .frame(maxWidth: .infinity ,alignment: .topLeading)
                        
                        Spacer()
                        Button {
                            
                        } label: {
                            Text(Constants.ButtonsTitle.helpSupport)
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(Color(Color.redColor))
                        }
                        
                    }
                    .padding()
                    DividerCapsule(height: 1, color: .gray.opacity(0.5))
                        .padding(.bottom)
                    
                    ScrollView{
                        VStack{
                            ZStack{
                                Group{
                                    //// profile can be changed
                                    //// by clicking on it
                                    AsyncImage(url: vm.profileResponse.imageUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                        
                                    } placeholder: {
                                        if vm.profileResponse.imageUrl != nil || errorVM.isLoading {
                                            ZStack {
                                                LoadingView(isLoading: $errorVM.loaderLoading, size: 20)
                                                    .frame(maxWidth: .infinity, alignment: .center)
                                            }
                                        } else {
                                            Image(Constants.Images.person)
                                                .resizable()
                                                .scaledToFill()
                                            
                                        }
                                    }
                                    if errorVM.isLoading {
                                        LoadingView(isLoading: $errorVM.loaderLoading, size: 20)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                    }
                                }
                                .frame(width: 124, height: 124)
                                .clipShape(Circle())
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "pencil.circle.fill")
                                        .font(.system(size: 30)).foregroundColor(Color(Color.redColor))
                                    
                                }
                            }
                            .onTapGesture {
                                // toggle edit profile button
                                vm.editPhotos.toggle()
                            }
                            .photosPicker(isPresented: $vm.openPhotosPicker, selection: $photosPicker)
                            .onChange(of: photosPicker) { _ in
                                Task{
                                    guard let items = photosPicker.first else{ return }
                                    if let data = try? await items.loadTransferable(type: Data.self){
                                        if let uiImage = UIImage(data: data) {
                                            errorVM.isLoading = true
                                            vm.apiCall(method: .addImage, httpMethod: .PUT, data: ["image": uiImage])
                                        }
                                    }
                                }
                            }
                                
                            
                            
                             ///confirmation dialog
                             ///prompting user with options
                             ///to get image from galler
                             ///to click a picture
                            .confirmationDialog("", isPresented : $vm.editPhotos) {
                                Button(Constants.Headings.selectFromGallery) {
                                    vm.openPhotosPicker.toggle()
                                }
                            }

                            
                            (Text(vm.userData?.status.data?.first_name ?? "No") + Text(" ") +
                             Text(vm.userData?.status.data?.last_name ?? "Name"))
                            .font(.system(size: 20, design: .rounded))
                            .bold()
                            .padding(.bottom, 30)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text(Constants.Headings.verifyProfile)
                                    .font(.system(size: 18, design: .rounded))
                                    .fontWeight(.semibold)
                                
                                ForEach(DataArrays.profilePlusButtonArray, id: \.self){button in
                                    
                                    Button {
                                        profileVM.toDisplayPhoneVerification.toggle()
                                    } label: {
                                        ProfilePlusButton(image: button[0], name: button[1])
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            DividerCapsule(height: 1, color: .gray.opacity(0.3))
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text(Constants.Headings.aboutYou)
                                    .font(.system(size: 18, design: .rounded))
                                    .fontWeight(.semibold)

                                NavigationLink {
                                    BioView(vm: vm, profileVM: profileVM)
                                } label: {
                                    if vm.userData?.status.data?.bio == nil {
                                        ProfilePlusButton(image: Constants.Images.plusCircle, name: Constants.ButtonsTitle.addMiniBio)
                                    } else {
                                        HStack{
                                            Image(systemName: Constants.Images.checkmarkFilled)
                                                .foregroundColor(Color(Color.redColor))
                                            Text(vm.userData?.status.data?.bio ?? "")
                                                .foregroundColor(.gray)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .font(.system(size: 16, design: .rounded))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .foregroundColor(.blue)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            DividerCapsule(height: 1, color: .gray.opacity(0.3))
                            
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
                                vm.toLogOut.toggle()
                                
                            } label: {
                                Text(Constants.ButtonsTitle.logOut)
                                    .font(.system(size: 20, design: .rounded))
                                    .bold()
                                    .foregroundColor(Color(Color.redColor))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                            }
                            .padding(.vertical)
                        }
                        .padding(.top)
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
            }
            .confirmationDialog(Constants.Headings.logOutHeading, isPresented: $vm.toLogOut, actions: {
                Button(Constants.ButtonsTitle.logOut, role: .destructive) {
                    vm.apiCall(method: .signOut, httpMethod: .GET, data: vm.getData(method: .signOut))
                }
            }, message: {
                Text(Constants.Headings.logOutHeading)
            })
            .fullScreenCover(isPresented: $profileVM.toDisplayPhoneVerification, content: {
                PhoneVerificationView(profileVM: profileVM)
            })
            .onAppear {
                vm.userId = vm.userData?.status.data?.id ?? 0
                vm.getProfileApiCall(method: .getDetails, httpMethod: .GET, data: [:])
                profileVM.vehicleListArray = profileVM.vehicleResponseList.data
                profileVM.isVehicleViewSelected = false
                profileVM.isAddingNewVehicle = false
            }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: SignInSignUpViewModel(), profileVM: ProfileViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
    }
}
