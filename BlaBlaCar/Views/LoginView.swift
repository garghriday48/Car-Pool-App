//
//  LoginView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var vm: AuthViewModel
    @EnvironmentObject var navigationVM: NavigationViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            EmailPasswordView(navigationVM: navigationVM)


        }
        .alert(Constants.ErrorBox.error, isPresented: $errorVM.hasResponseError, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) {
            }
        }, message: {
            Text(errorVM.errorMessage1)
        })

        .alert(Constants.ErrorBox.error, isPresented: $errorVM.hasError, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) {
            }
        }, message: {
            Text(errorVM.errorMessage?.errorDescription ?? "")
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
            .environmentObject(AuthViewModel())
            .environmentObject(NavigationViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
    }
}
