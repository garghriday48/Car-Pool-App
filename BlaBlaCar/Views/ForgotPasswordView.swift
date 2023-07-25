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
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    var body: some View {
        VStack {
            HStack{
                BackButton(image: Constants.Images.cross) {
                    vm.isGoingBackToMainPage.toggle()
                }
                .font(.title2)
                
                Text(Constants.Headings.forgotPassword)
                    .font(.system(size: 18, design: .rounded))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding([.horizontal,.top])
            DividerCapsule(height: 1, color: .gray.opacity(0.5))
                .padding(.bottom)
            
            Text("Step \(Int(vm.forgotPasswordView.rawValue/33.33)) of 3")
                .font(.system(size: 14)).bold()
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
                vm.forgotPasswordView = .email
                vm.forgotPassEmail = ""
                vm.emailValid = ""
                profileVM.otpFields = Array(repeating: "", count: 4)
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
            .environmentObject(ResponseErrorViewModel.shared)
    }
}
