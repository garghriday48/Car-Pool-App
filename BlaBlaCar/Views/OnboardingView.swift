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
                .padding()
            
            // to show heading and buttons for signin and signup
            VStack(alignment: .leading){
                VStack {
                    Text(Constants.Headings.welcome)
                        .font(.system(size: 28,design: .rounded))
                        .bold()
                        
                    
                    Text(Constants.Headings.onBoardingPage)
                        .font(.system(size: 18,design: .rounded))
                        .foregroundColor(.black.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                Button {
                    vm.isNewUser = true
                    navigationVM.push(.SignupPage)
                } label: {
                    ButtonView(buttonName: Constants.ButtonsTitle.signUp, border: false)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(Color.redColor))
                            )
                }
                Button {
                    vm.isNewUser = false
                    navigationVM.push(.LoginPage)
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
