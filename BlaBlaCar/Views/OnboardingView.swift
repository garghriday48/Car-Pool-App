//
//  OnboardingView.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var vm: SignInSignUpViewModel
    @EnvironmentObject var navigationVM: NavigationViewModel
    
    var body: some View {
        VStack{
            Image(Constants.Images.background)
                .resizable()
                //.ignoresSafeArea()
                .padding()
            
            // to show heading and buttons for signin and signup
            VStack(alignment: .leading){
                Text(Constants.Headings.onBoardingPage)
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button {
                    vm.isNewUser = true
                    navigationVM.push(.MainSigninSignupView)
                } label: {
                    ButtonView(buttonName: Constants.ButtonsTitle.signUp, border: false)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color(Color.redColor))
                            )
                }
                Button {
                    vm.isNewUser = false
                    navigationVM.push(.MainSigninSignupView)
                } label: {
                    ButtonView(buttonName: Constants.ButtonsTitle.logIn, border: true)
                }
            }
            .padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(vm: SignInSignUpViewModel())
    }
}
