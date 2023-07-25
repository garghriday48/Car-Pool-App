//
//  EmailPasswordView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct EmailPasswordView: View {
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @ObservedObject var navigationVM: NavigationViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text(Constants.Headings.emailPassHeading)
                .font(.system(size: 24, design: .rounded))
                .bold()
                .padding(.bottom, 40)
            
            InputFields(text        : $vm.userAuthData.user.email,
                        title       : Constants.TextfieldPlaceholder.email,
                        isPassOrNot : false,
                        keyboardType: .emailAddress,
                        capitalizationType: .never,
                        borderColor: vm.userAuthData.user.email.isEmpty ? .gray.opacity(0.6) : .black)
            .padding(.bottom, (vm.emailValid.isEmpty && vm.isNewUser) ? 20 : 0)
            .padding(.bottom, vm.isNewUser ? 0 : 10)
            if vm.isNewUser{
                HStack{
                    if !vm.emailValid.isEmpty{
                        Image(systemName: Constants.Images.infoImage)
                    }
                    Text(vm.emailValid)
                }
                .font(.system(size: 14))
                .animation(.easeOut, value: vm.signUpViews.rawValue)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            InputFields(text        :$vm.userAuthData.user.password,
                        title       :Constants.TextfieldPlaceholder.password,
                        isPassOrNot : true,
                        keyboardType: .default,
                        capitalizationType: .never,
                        borderColor: vm.userAuthData.user.password.isEmpty ? .gray.opacity(0.6) : .black)
            .padding(.bottom, (vm.passValid.isEmpty && vm.isNewUser) ? 20 : 0)
            if vm.isNewUser{
                HStack{
                    if !vm.passValid.isEmpty{
                        Image(systemName: Constants.Images.infoImage)
                    }
                    Text(vm.passValid)
                }
                .font(.system(size: 14))
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            if vm.isNewUser {
                InfoTextView(text: Constants.passDesc)
                    .padding(.leading, 2)
            }
            if !vm.isNewUser {
                NavigationLink {
                    ForgotPasswordView()
                } label: {
                    Text(Constants.Headings.forgotPass)
                        .font(.headline)
                        .fontDesign(.rounded)
                        .foregroundColor(Color(Color.redColor))
                }
                .padding(.vertical)
            }
            Spacer()
            if errorVM.isLoading {
                LoadingView(isLoading: $errorVM.loaderLoading, size: 20)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Button {
                    if vm.isNewUser{
                        vm.apiCall(method: .emailCheck, httpMethod: .GET, data: vm.getData(method: .emailCheck))
                    } else {
                        vm.apiCall(method: .signIn, httpMethod: .POST, data: vm.getData(method: .signIn))
                    }
                } label: {
                    ButtonView(buttonName: vm.isNewUser ? Constants.ButtonsTitle.next : Constants.ButtonsTitle.done,
                               border    : false)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill((vm.isNewUser && vm.emailPassBtnDisable) ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                        )
                }
                .disabled(vm.isNewUser ? vm.emailPassBtnDisable : false)
            }
        }
        .padding()
        .onChange(of: vm.userAuthData.user.email) { _ in
            vm.toValidateEmail()
        }
        .onChange(of: vm.userAuthData.user.password) { _ in
            vm.toValidatePassword(value: vm.userAuthData.user.password)
        }
    }
}

struct EmailPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EmailPasswordView(navigationVM: NavigationViewModel())
            .environmentObject(SignInSignUpViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
    }
}
