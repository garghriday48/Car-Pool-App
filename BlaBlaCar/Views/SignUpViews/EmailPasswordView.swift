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
    
    var body: some View {
        VStack(alignment: .leading){
            Text(Constants.Headings.emailPassHeading)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)
            
            InputFields(text        : $vm.userAuthData.user.email,
                        title       : Constants.TextfieldPlaceholder.email,
                        isPassOrNot : false,
                        keyboardType: .emailAddress)
            .padding(.bottom, (vm.emailValid.isEmpty && vm.isNewUser) ? 20 : 0)
            if vm.isNewUser{
                HStack{
                    if !vm.emailValid.isEmpty{
                        Image(systemName: Constants.Images.infoImage)
                    }
                    Text(vm.emailValid)
                        .font(.system(size: 15))
                }
                .animation(.easeOut, value: vm.signUpViews.rawValue)
                .padding(.leading)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            InputFields(text        :$vm.userAuthData.user.password,
                        title       :Constants.TextfieldPlaceholder.password,
                        isPassOrNot : true,
                        keyboardType: .default)
            .padding(.bottom, (vm.passValid.isEmpty && vm.isNewUser) ? 20 : 0)
            if vm.isNewUser{
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
            }
            if vm.isNewUser {
                InfoTextView(text: Constants.passDesc)
            }
            if !vm.isNewUser {
                NavigationLink {
                    
                } label: {
                    Text("Forgot password?")
                        .font(.headline)
                        .foregroundColor(Color(Color.redColor))
                }
                .padding()
            }
            Spacer()
            if vm.isLoading {
                LoadingView(isLoading: $vm.loaderLoading)
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
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
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
            vm.toValidatePassword()
        }
    }
}

struct EmailPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EmailPasswordView(navigationVM: NavigationViewModel())
            .environmentObject(SignInSignUpViewModel())
    }
}
