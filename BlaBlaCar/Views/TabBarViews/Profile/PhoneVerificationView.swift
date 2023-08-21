//
//  PhoneVerificationView.swift
//  BlaBlaCar
//
//  Created by Pragath on 20/06/23.
//

import SwiftUI

struct PhoneVerificationView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @EnvironmentObject var vm: AuthViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    @ObservedObject var profileVM: ProfileViewModel
    
    
    var body: some View {
        VStack {
            HStack{
                BackButton(image: Constants.Images.cross) {
                    self.dismiss()
                    vm.phoneVerificationSteps = .numberView
                }
                .font(.title2)
                .bold()
                
                Text(Constants.Headings.phoneVerification)
                    .font(.system(size: 18, design: .rounded))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 4, color: Color(.systemGray3))
                .padding(.bottom)
            
            Text("Step \(Int(vm.phoneVerificationSteps.rawValue/50)) of 2")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(Color.redColor))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            ProgressBar(percent: vm.phoneVerificationSteps.rawValue)
                .animation(.easeOut, value: vm.phoneVerificationSteps.rawValue)
            
            switch vm.phoneVerificationSteps {
            case .numberView : PhoneInputView(profileVM: profileVM)
            case .numberOtpView: OtpInputView()
            }
        }
        .frame(maxHeight: .infinity,alignment: .top)
        .padding(.vertical)
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

struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerificationView(profileVM: ProfileViewModel())
    }
}
