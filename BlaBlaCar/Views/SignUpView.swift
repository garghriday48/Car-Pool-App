//
//  EmailPasswordPage.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

struct SignUpView: View {
    
    var genderArray = ["Male", "Female", "Other"]
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @EnvironmentObject var navigationVM: NavigationViewModel
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            
            VStack {
                
                Text("Step \(Int(vm.signUpViews.rawValue/25)) of 4")
                    .font(.headline)
                    .foregroundColor(Color(Color.redColor))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                ProgressBar(percent: vm.signUpViews.rawValue)
                    .animation(.easeOut, value: vm.signUpViews.rawValue)
            }
            .padding(.vertical)
            
            switch vm.signUpViews{
            case .emailPasswordView:
                EmailPasswordView(navigationVM: navigationVM)
            case .fullNameView:
                FullNameView(navigationVM: navigationVM)
            case .dobView:
                DobView(navigationVM: navigationVM)
            case .genderView:
                GenderView(navigationVM: navigationVM)
            }
        }
        .blur(radius: vm.isGoingBackToMainPage ? 5 : 0)

        .onAppear{
            vm.signUpViews = .emailPasswordView
            vm.userAuthData = UserAuthData(user: User(email: String(), password: String(), firstName: String(), lastName: String(), dob: String(), title: String()))
            vm.emailValid       = String()
            vm.passValid        = String()
            vm.firstNameValid   = String()
            vm.lastNameValid    = String()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(Constants.Headings.signUpPagesHeading)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: BackButton(image: Constants.Images.backArrow) {
            vm.isGoingBackToMainPage = true
        })
        .confirmationDialog(Constants.Headings.backAlertHeading, isPresented: $vm.isGoingBackToMainPage, actions: {
            Button(Constants.ButtonsTitle.yes, role: .destructive) {
                navigationVM.pop(to: .MainSigninSignupView)
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
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(SignInSignUpViewModel())
            .environmentObject(NavigationViewModel())
    }
}
