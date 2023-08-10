//
//  PhoneOtpInputView.swift
//  BlaBlaCar
//
//  Created by Pragath on 20/06/23.
//

import SwiftUI

struct OtpInputView: View {
    @EnvironmentObject var vm: SignInSignUpViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    // MARK: textfield focusstate
    @FocusState var activeTextField: OTPField?
    
    var body: some View {
        VStack(alignment: .leading){
            Text(Constants.Headings.verification)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            HStack(spacing: 30){
                ForEach(0..<4, id:\.self){ index in
                    VStack(spacing: 8) {
                        TextField("", text: $profileVM.otpFields[index])
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .multilineTextAlignment(.center)
                            .focused($activeTextField, equals: profileVM.activeStateForIndex(index: index))
                            
                        
                        Rectangle()
                            .fill(activeTextField ==  profileVM.activeStateForIndex(index: index) ? .red : .gray.opacity(0.5))
                            .frame(height: 4)
                        
                    }
                    .frame(width: 40)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical)

            Button {
                switch vm.typeOfOtp {
                case .phoneVerification: break
                case .forgotPassword:
                    
                    vm.forgotPassApiCall(method: .otp, httpMethod: .POST, data: [Constants.DictionaryForApiCall.email : vm.forgotPassEmail, Constants.DictionaryForApiCall.otp: vm.otp])
                }
            } label: {
                ButtonView(buttonName: Constants.ButtonsTitle.verify, border: false)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(profileVM.checkStates() ? Color(Color.redColor) : Color(Color.redColor).opacity(0.2))
                    )
            }
            .disabled(!profileVM.checkStates())
            .padding(.vertical)
            
            HStack(spacing: 12) {
                Text(Constants.Headings.didntGetOtp)
                    .font(.caption)
                    .foregroundColor(.gray)
                Button {
                    switch vm.typeOfOtp {
                    case .phoneVerification: break
                    case .forgotPassword:
                        
                        vm.forgotPassApiCall(method: .forgotPassEmail, httpMethod: .POST, data: [Constants.DictionaryForApiCall.email: vm.forgotPassEmail])
                    }
                } label: {
                    Text(Constants.ButtonsTitle.resend)
                        .font(.callout)
                }

            }
            .padding(.bottom)
            
            if vm.typeOfOtp == .forgotPassword {
                HStack(spacing: 12) {
                    Text(Constants.Headings.changeEmail)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Button {
                        switch vm.typeOfOtp {
                        case .phoneVerification: break
                        case .forgotPassword:
                            vm.forgotPasswordView = .email
                            vm.forgotPassEmail = vm.forgotPassEmail
                        }
                    } label: {
                        Text(Constants.ButtonsTitle.enterEmail)
                            .font(.callout)
                    }
                }
                .padding(.bottom)
            }
            
            if errorVM.isLoading {
                LoadingView(isLoading: $errorVM.loaderLoading, size: 20)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            

        }
        .padding()
        .frame(maxHeight: .infinity,alignment: .topLeading)
            
        .onChange(of: profileVM.checkStates(), perform: { newValue in
            if newValue {
                for index in profileVM.otpFields {  vm.otp += index }
            } else { vm.otp = "" }
        })
        
        .onChange(of: profileVM.otpFields) { newValue in
            profileVM.OTPCondition(value: newValue)
            
            // MARK: moving to next field if current textfield is filled
            
            for index in 0..<3 where newValue[index].count == 1 && profileVM.activeStateForIndex(index: index) == activeTextField {
                activeTextField = profileVM.activeStateForIndex(index: index + 1)
            }
            
            // MARK: moving back to previous field
            
            for index in 1..<4 where newValue[index].isEmpty && !newValue[index - 1].isEmpty {
                activeTextField = profileVM.activeStateForIndex(index: index - 1)
            }
        }
    }
    
}

struct OtpInputView_Previews: PreviewProvider {
    static var previews: some View {
        OtpInputView()
            .environmentObject(SignInSignUpViewModel())
            .environmentObject(ProfileViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
    }
}

