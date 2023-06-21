//
//  ForgotPasswordView.swift
//  BlaBlaCar
//
//  Created by Pragath on 21/06/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment (\.dismiss) var dismiss
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    
    var body: some View {
        VStack {
            HStack{
                BackButton(image: Constants.Images.cross) {
                    vm.isGoingBackToMainPage.toggle()
                    vm.forgotPasswordView = .email
                }
                .font(.title)
                .bold()
                
                Text(Constants.Headings.forgotPassword)
                    .font(.title3)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 4, color: Color(.systemGray3))
                .padding(.bottom)
            
            Text("Step \(Int(vm.forgotPasswordView.rawValue/33.33)) of 3")
                .font(.headline)
                .foregroundColor(Color(Color.redColor))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            ProgressBar(percent: vm.forgotPasswordView.rawValue)
                .animation(.easeOut, value: vm.forgotPasswordView.rawValue)
            
            switch vm.forgotPasswordView {
            case .email : EmailView()
            case .otp: OtpInputView()
            case .resetPassword:  ResetPasswordView()
            }
        }
        .blur(radius: vm.isGoingBackToMainPage ? 5 : 0)
        .navigationBarBackButtonHidden()
        .frame(maxHeight: .infinity,alignment: .top)
        .padding(.vertical)
        .confirmationDialog(Constants.Headings.backAlertHeading, isPresented: $vm.isGoingBackToMainPage, actions: {
            Button(Constants.ButtonsTitle.yes, role: .destructive) {
                self.dismiss()
            }
        }, message: {
            Text(Constants.Headings.backAlertHeading)
        })
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(SignInSignUpViewModel())
    }
}
