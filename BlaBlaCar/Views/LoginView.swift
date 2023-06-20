//
//  LoginView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @EnvironmentObject var navigationVM: NavigationViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            EmailPasswordView(navigationVM: navigationVM)


        }
        .alert(Constants.ErrorBox.error, isPresented: $vm.hasEmailError, actions: {
            Button(Constants.ErrorBox.okay, role: .destructive) {
                navigationVM.pop(to: .MainSigninSignupView)
                
            }
        }, message: {
            Text(vm.errorMessage1)
        })
        .alert(Constants.ErrorBox.error, isPresented: $vm.hasError, actions: {
            Button(Constants.ErrorBox.okay, role: .destructive) {
                navigationVM.pop(to: .MainSigninSignupView)
                
            }
        }, message: {
            Text(vm.errorMessage1)
        })

        .onAppear{
            vm.userAuthData = UserAuthData(user: User(email: String(), password: String(), firstName: String(), lastName: String(), dob: String(), title: String()))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(image: Constants.Images.backArrow, action: {
            presentationMode.wrappedValue.dismiss()
        }))
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
