//
//  EditProfileView.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct EditProfileView: View {
    
    @ObservedObject var vm: SignInSignUpViewModel
    @ObservedObject var profileVM: ProfileViewModel
    @Environment (\.dismiss) var dismiss
    
    @State var photosPicker: [PhotosPickerItem] = []
    
    var genderArray = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack{
                HStack{
                    BackButton(image: Constants.Images.cross) {
                        profileVM.isGoingBack = true
                    }
                    .font(.title)
                    .bold()
                    
                    Text(Constants.Headings.editProfile)
                        .font(.title3)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity ,alignment: .topLeading)
                }
                .padding()
                DividerCapsule(height: 4, color: Color(.systemGray3))
                ScrollView{
                    VStack{
                        Text(Constants.Headings.aboutMe)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        //PhotoPickerView(selectedPic: $profileVM.selectedPic)
                        //// profile can be changed
                        //// by clicking on it
                        AsyncImage(url: vm.profileResponse.imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            if vm.profileResponse.imageUrl != nil {
                                ZStack {
                                    Color.gray.opacity(0.1)
                                    ProgressView()
                                }
                            } else {
                                Image(Constants.Images.person)
                                    .resizable()
                                    .scaledToFill()
                                    
                            }
                        }
                        .frame(width: 124, height: 124)
                        .clipShape(Circle())
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


                        ForEach($vm.updatingUserArray){$profile in
                            ProfileTextField(profileVM: profileVM, vm: vm,  textField: $profile.textField, textFieldType: profile.type, heading: profile.heading, keyboardType: profile.keyboardType ?? .default, capitalizationType: profile.capitalizationType ?? .never)
                                
                        }
                        
                        HStack{
                            //Text("please print")
                            if !vm.nameValid.isEmpty{
                                Image(systemName: Constants.Images.infoImage)
                            }
                            Text(vm.nameValid)
                                .font(.system(size: 15))
                        }
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                        
                        Button {
                            vm.apiCall(method: .profileUpdate, httpMethod: .PUT, data: vm.getData(method: .profileUpdate))

                        } label: {
                            ButtonView(buttonName: Constants.ButtonsTitle.done, border: false)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color(Color.redColor))
                                    )
                                .padding(.top)
                        }
                    }
                    .padding()
                }
                .sheet(isPresented: $profileVM.toShowPicker) {
                    PickerView(isDatePicker : $profileVM.isDatePicker,
                               toShowPicker : $profileVM.toShowPicker,
                               myDate       : $profileVM.myDate,
                               selectedIndex: $profileVM.selectedIndex)
                    
                    .frame(alignment: .bottom)
                    .animation(.easeIn, value: profileVM.toShowPicker)
                    .presentationDetents([.fraction(0.32)])
                    
                }
            
        }
        .scrollDismissesKeyboard(.immediately)
        .frame(maxWidth: .infinity , alignment: .leading)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            vm.updatingUserArray = profileVM.editProfileArray
            profileVM.firstName = vm.userData?.status.data?.first_name ?? ""
            profileVM.lastName = vm.userData?.status.data?.last_name ?? ""
            profileVM.gender = vm.userData?.status.data?.title ?? ""
            profileVM.dob = vm.userData?.status.data?.dob ?? ""
            profileVM.phnNumber = vm.userData?.status.data?.phone_number ?? ""
            profileVM.email = vm.userData?.status.data?.email ?? ""
        }
        .onTapGesture {
            profileVM.toShowPicker = false
        }
        .onChange(of: vm.updateProfileDone, perform: { _ in
            if vm.updateProfileDone {
                self.dismiss()
            }
        })
        .onChange(of: profileVM.myDate) { _ in
            profileVM.dob = profileVM.myDate.formatted(date: .abbreviated, time: .omitted)
        }
        .onChange(of: profileVM.selectedIndex, perform: { _ in
            profileVM.gender = genderArray[profileVM.selectedIndex]
        })
        .onDisappear{
            profileVM.toShowPicker = false
        }
        .confirmationDialog(Constants.Headings.backAlertHeading, isPresented: $profileVM.isGoingBack, actions: {
            Button(Constants.ButtonsTitle.yes, role: .destructive) {
                self.dismiss()
            }
        }, message: {
            Text(Constants.Headings.backAlertHeading)
        })
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(vm: SignInSignUpViewModel(), profileVM: ProfileViewModel())
    }
}
