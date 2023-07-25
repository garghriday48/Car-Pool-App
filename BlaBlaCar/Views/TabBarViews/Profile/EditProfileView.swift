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
    
    
    
    var genderArray = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack{
                HStack{
                    BackButton(image: Constants.Images.cross) {
                        profileVM.isGoingBack = true
                    }
                    .font(.title2)
                    .bold()
                    
                    Text(Constants.Headings.editProfile)
                        .font(.system(size: 18, design: .rounded))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity ,alignment: .topLeading)
                }
                .padding()
            DividerCapsule(height: 1, color: .gray.opacity(0.5))
                ScrollView{
                    VStack{

                        ForEach($vm.updatingUserArray){$profile in
                            ProfileTextField(profileVM: profileVM, vm: vm,  textField: $profile.textField, textFieldType: profile.type, heading: profile.heading, keyboardType: profile.keyboardType ?? .default, capitalizationType: profile.capitalizationType ?? .never)
                                
                        }
                        Button {
                            vm.apiCall(method: .profileUpdate, httpMethod: .PUT, data: vm.getData(method: .profileUpdate))

                        } label: {
                            ButtonView(buttonName: Constants.ButtonsTitle.done, border: true)
                                .padding(.trailing, 8)
                        }
                        .disabled(!vm.nameValid.isEmpty)
                        
                        HStack{
                            if !vm.nameValid.isEmpty{
                                Image(systemName: Constants.Images.infoImage)
                            }
                            Text(vm.nameValid)
                                
                        }
                        .font(.system(size: 14))
                        .foregroundColor(Color(Color.redColor))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    }
                    .padding()
                }
                .sheet(isPresented: $profileVM.toShowPicker) {
                    PickerView(isDatePicker : $profileVM.isDatePicker,
                               toShowPicker : $profileVM.toShowPicker,
                               myDate       : $profileVM.myDate,
                               selectedIndex: $profileVM.selectedIndex)
                    .animation(.easeIn, value: profileVM.toShowPicker)
                    .presentationDetents(profileVM.isDatePicker ? [.height(240)] : [.fraction(0.30)])
                    
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
