//
//  EmailPasswordPage.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

struct SignUpView: View {
    
    var genderArray = ["Male", "Female", "Other"]
    
    @EnvironmentObject var vm: AuthViewModel
    @EnvironmentObject var navigationVM: NavigationViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            
            VStack {
                
                Text("Step \(Int(vm.signUpViews.rawValue/25)) of 4")
                    .font(.system(size: 14)).bold()
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
        .navigationTitle(Constants.Headings.signUpPagesHeading).fontDesign(.rounded)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: BackButton(image: Constants.Images.backArrow) {
            if vm.signUpViews == .emailPasswordView && vm.userAuthData.user.email.isEmpty && vm.userAuthData.user.email.isEmpty {
                navigationVM.paths = []
            } else {
                vm.isGoingBackToMainPage = true
            }
        })
        .confirmationDialog(Constants.Headings.backAlertHeading, isPresented: $vm.isGoingBackToMainPage, actions: {
            Button(Constants.ButtonsTitle.yes, role: .destructive) {
                navigationVM.paths = []
            }
        }, message: {
            Text(Constants.Headings.backAlertHeading)
        })
        
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
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthViewModel())
            .environmentObject(NavigationViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
    }
}
