//
//  MainSignupView.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

struct MainSignInSignUpView: View {
    
    @ObservedObject var vm: AuthViewModel
    @EnvironmentObject var navigationVM: NavigationViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Image(Constants.Images.background)
                .resizable()
                .padding()
            VStack(alignment: .leading){
                Text(vm.isNewUser ? Constants.Headings.signUpHeading : Constants.Headings.loginHeading)
                    .font(.largeTitle)
                    .bold()
                Button {
                    if vm.isNewUser {
                        navigationVM.push(.SignupPage)
                    } else{
                        navigationVM.push(.LoginPage)
                    }
                } label: {
                    SocialLoginButton(image: Image(Constants.Images.mail), text: Text(Constants.ButtonsTitle.continueWithEmail), color: Color(Color.redColor))
                        
                }
                Spacer()
                
                Divider()
                Text(vm.isNewUser ? Constants.Headings.isMember : Constants.Headings.notMember)
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                Button {
                    if vm.isNewUser {
                        vm.isNewUser = false
                        navigationVM.push(.LoginPage)
                    } else{
                        vm.isNewUser = true
                        navigationVM.push(.SignupPage)
                    }
                } label: {
                    ButtonView(buttonName: vm.isNewUser ? Constants.ButtonsTitle.logIn : Constants.ButtonsTitle.signUp, border: true)
                }
                //Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(image: Constants.Images.backArrow, action: {
            presentationMode.wrappedValue.dismiss()
        }))

    }
}

struct MainSignInSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        MainSignInSignUpView(vm: AuthViewModel())
    }
}
