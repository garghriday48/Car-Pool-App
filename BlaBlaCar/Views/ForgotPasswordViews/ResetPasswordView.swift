//
//  ResetPasswordView.swift
//  BlaBlaCar
//
//  Created by Pragath on 21/06/23.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var vm: AuthViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            Text(Constants.Headings.resetPassword)
                .font(.system(size: 24, design: .rounded))
                .bold()
                .padding(.bottom, 40)
            
            VStack{

                InputFields(text        :$vm.changePassword.password,
                            title       :Constants.TextfieldPlaceholder.password,
                            isPassOrNot : true,
                            keyboardType: .default,
                            capitalizationType: .never,
                            borderColor: vm.changePassword.password.isEmpty ? .gray.opacity(0.6) : .black)
                .padding(.bottom, (vm.passValid.isEmpty) ? 20 : 0)
                
                HStack{
                    if !vm.passValid.isEmpty{
                        Image(systemName: Constants.Images.infoImage)
                    }
                    Text(vm.passValid)
                }
                .font(.system(size: 14))
                .padding(.leading)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                InputFields(text        :$vm.changePassword.password_confirmation,
                            title       :Constants.TextfieldPlaceholder.confirmPassword,
                            isPassOrNot : true,
                            keyboardType: .default,
                            capitalizationType: .never,
                            borderColor: vm.changePassword.password_confirmation.isEmpty ? .gray.opacity(0.6) : .black)
                .padding(.bottom, (vm.confirmPass.isEmpty) ? 20 : 0)
                HStack{
                    if !vm.confirmPass.isEmpty{
                        Image(systemName: Constants.Images.infoImage)
                    }
                    Text(vm.confirmPass)
                }
                .font(.system(size: 14))
                .padding(.leading)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Spacer()
                if errorVM.isLoading {
                    LoadingView(isLoading: $errorVM.loaderLoading, size: 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Button {
                        vm.forgotPassApiCall(method: .resetPassword, httpMethod: .POST, data: vm.getData(method: .resetPassword))
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
        }
        .padding()

        .onAppear{
            profileVM.otpFields = Array(repeating: "", count: 4)
            vm.passValid = ""
            vm.changePassword.password = ""
            vm.changePassword.password_confirmation = ""
            vm.changePassword.current_password = UserDefaults.standard.string(forKey: Constants.UserDefaultKeys.password) ?? ""
        }
        .onChange(of: vm.changePassword.password) { _ in
            vm.toValidatePassword(value: vm.changePassword.password)
        }
        .onChange(of: vm.changePassword.password_confirmation) { _ in
            vm.toValidateSamePass()
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .environmentObject(AuthViewModel())
            .environmentObject(ProfileViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
    }
}

