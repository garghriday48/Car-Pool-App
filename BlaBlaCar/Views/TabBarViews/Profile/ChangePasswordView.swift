//
//  ChangePasswordView.swift
//  BlaBlaCar
//
//  Created by Pragath on 20/06/23.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    
    @ObservedObject var profileVM: ProfileViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                BackButton(image: Constants.Images.cross) {
                    vm.isGoingBackToMainPage.toggle()
                    
                }
                .font(.title)
                .bold()
                
                Text(Constants.Headings.changePassword)
                    .font(.title3)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 4, color: Color(.systemGray3))
                .padding(.bottom)
            
            VStack{
                VStack{
                    Text(vm.changePassword.current_password)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white))
                        .shadow(radius: 2)
                        .foregroundColor(.black)
                        
                }
            
                .padding(.bottom, 20)

                InputFields(text        :$vm.changePassword.password,
                            title       :Constants.TextfieldPlaceholder.password,
                            isPassOrNot : true,
                            keyboardType: .default,
                            capitalizationType: .never)
                .padding(.bottom, (vm.passValid.isEmpty) ? 20 : 0)
                
                HStack{
                    if !vm.passValid.isEmpty{
                        Image(systemName: Constants.Images.infoImage)
                    }
                    Text(vm.passValid)
                        .font(.system(size: 15))
                }
                .padding(.leading)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                InputFields(text        :$vm.changePassword.password_confirmation,
                            title       :Constants.TextfieldPlaceholder.confirmPassword,
                            isPassOrNot : true,
                            keyboardType: .default,
                            capitalizationType: .never)
                .padding(.bottom, (vm.confirmPass.isEmpty) ? 20 : 0)
                HStack{
                    if !vm.confirmPass.isEmpty{
                        Image(systemName: Constants.Images.infoImage)
                    }
                    Text(vm.confirmPass)
                        .font(.system(size: 15))
                }
                .padding(.leading)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Spacer()
                if vm.isLoading {
                    LoadingView(isLoading: $vm.loaderLoading)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Button {
                        vm.apiCall(method: .changePassword, httpMethod: .PATCH, data: vm.getData(method: .changePassword))
                    } label: {
                        ButtonView(buttonName: Constants.ButtonsTitle.done,
                                   border    : false)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill((vm.changePasswordBtnDisable) ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                        )
                    }
                    .disabled(vm.changePasswordBtnDisable)
                }
            }
            .padding()
        }
        .confirmationDialog(Constants.Headings.backAlertHeading, isPresented: $vm.isGoingBackToMainPage, actions: {
            Button(Constants.ButtonsTitle.yes, role: .destructive) {
                self.dismiss()
            }
        }, message: {
            Text(Constants.Headings.backAlertHeading)
        })
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
        .onAppear{
            vm.passValid = ""
            vm.changePassword.current_password = UserDefaults.standard.string(forKey: Constants.UserDefaultKeys.password) ?? ""
        }
        .onChange(of: vm.changePassword.password) { _ in
            vm.toValidatePassword(value: vm.changePassword.password)
        }
        .onChange(of: vm.changePassword.password_confirmation) { _ in
            vm.toValidateSamePass()
        }
        .onChange(of: vm.toShowChangePassword) { _ in
            if !vm.toShowChangePassword {
                vm.changePassword.password = ""
                vm.changePassword.password_confirmation = ""
            }
        }

    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(profileVM: ProfileViewModel())
            .environmentObject(SignInSignUpViewModel())
    }
}

