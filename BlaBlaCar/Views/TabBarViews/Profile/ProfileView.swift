//
//  ProfileView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct ProfileView: View {
    
    @ObservedObject var vm: AuthViewModel
    @ObservedObject var profileVM: ProfileViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    @State var photosPicker: [PhotosPickerItem] = []
    
    @State var phoneVerified = false
    @State var emailVerified = false
    
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
                                    ImageView(size: 124,
                                              imageName: vm.profileResponse.imageUrl,
                                              condition: vm.profileResponse.imageUrl != nil || errorVM.isLoading)
//                                    AsyncImage(url: vm.profileResponse.imageUrl) { image in
//                                        image
//                                            .resizable()
//                                            .scaledToFill()
//
//                                    } placeholder: {
//                                        if vm.profileResponse.imageUrl != nil || errorVM.isLoading {
//                                            ZStack {
//                                                LoadingView(isLoading: $errorVM.loaderLoading, size: 20)
//                                                    .frame(maxWidth: .infinity, alignment: .center)
//                                            }
//                                        } else {
//                                            Image(Constants.Images.person)
//                                                .resizable()
//                                                .scaledToFill()
//
//                                        }
//                                    }
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
                                
                                Button {
                                    vm.goToEmailActivation.toggle()
                                    vm.email = vm.userData?.status.data?.email ?? ""
                                } label: {
                                    ProfilePlusButton(image: vm.profileResponse.user?.activated ?? false ? Constants.Images.verificationCheckmark : Constants.Images.plusCircle , name:  vm.profileResponse.user?.activated ?? false ? vm.profileResponse.user?.email ?? "" : Constants.Headings.confirmEmail, textColor: vm.profileResponse.user?.activated ?? false ? .gray : Color.redColor)
                                }
                                .disabled(emailVerified)
                                
                                Button {
                                    vm.toDisplayPhoneVerification.toggle()
                                } label: {
                                    ProfilePlusButton(image: vm.profileResponse.user?.phone_verified ?? false ? Constants.Images.verificationCheckmark : Constants.Images.plusCircle, name:  vm.profileResponse.user?.phone_verified ?? false ? vm.profileResponse.user?.phone_number ?? "" : Constants.Headings.confirmPhn, textColor: vm.profileResponse.user?.phone_verified ?? false ? .gray : Color.redColor)
                                }
                                .disabled(phoneVerified)
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
                                        ProfilePlusButton(image: Constants.Images.plusCircle, name: Constants.ButtonsTitle.addMiniBio, textColor: Color.redColor)
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
                    .refreshable {
                        //vm.userId = vm.userData?.status.data?.id ?? 0
                        vm.getProfileApiCall(method: .getDetails, httpMethod: .GET, data: [:])
                        phoneVerified = vm.profileResponse.user?.phone_verified ?? false
                        emailVerified = vm.profileResponse.user?.activated ?? false
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
            .fullScreenCover(isPresented: $vm.toDisplayPhoneVerification, content: {
                PhoneVerificationView(profileVM: profileVM)
            })
            .fullScreenCover(isPresented: $vm.goToEmailActivation, content: {
                EmailView(emailViewType: .emailVerification)
            })
            .onAppear {
                vm.userId = vm.userData?.status.data?.id ?? 0
                vm.getProfileApiCall(method: .getDetails, httpMethod: .GET, data: [:])
                
                profileVM.vehicleListArray = profileVM.vehicleResponseList.data ?? []
                profileVM.isVehicleViewSelected = false
                profileVM.isAddingNewVehicle = false
                
                phoneVerified = vm.profileResponse.user?.phone_verified ?? false
                emailVerified = vm.profileResponse.user?.activated ?? false
            }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: AuthViewModel(), profileVM: ProfileViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
    }
}
