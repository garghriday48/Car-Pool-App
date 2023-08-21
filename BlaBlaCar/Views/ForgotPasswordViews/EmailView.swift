//
//  EmailView.swift
//  BlaBlaCar
//
//  Created by Pragath on 21/06/23.
//

import SwiftUI

struct EmailView: View {
    
    @EnvironmentObject var vm: AuthViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    var emailViewType: ReuseEmailView
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            if emailViewType == .emailVerification {
                VStack{
                    HStack{
                        BackButton(image: Constants.Images.cross) {
                            self.dismiss()
                        }
                        .font(.title2)
                        
                        Text(Constants.Headings.emailVerification)
                            .font(.system(size: 18, design: .rounded))
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity ,alignment: .topLeading)
                    }
                    .padding([.horizontal,.top])
                    DividerCapsule(height: 1, color: .gray.opacity(0.5))
                        .padding(.bottom)
                }
                .padding(.horizontal, -20)
                
            }
            Text(Constants.Headings.enterEmail)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .padding(.bottom, 40)
            InputFields(text        : emailViewType == .forgotPass ? $vm.forgotPassEmail : $vm.email,
                        title       : Constants.TextfieldPlaceholder.email,
                        isPassOrNot: false,
                        keyboardType: .emailAddress,
                        capitalizationType: .never,
                        borderColor: vm.forgotPassEmail.isEmpty ? .gray.opacity(0.5) : .black,
                        isDisabled: emailViewType == .forgotPass ? false : true)
            
            .padding(.bottom, (vm.emailValid.isEmpty) ? 20 : 0)

            HStack{
                if !vm.emailValid.isEmpty{
                    Image(systemName: Constants.Images.infoImage)
                }
                Text(vm.emailValid)
                    
            }
            .font(.system(size: 14))
            .animation(.easeOut, value: vm.forgotPasswordView.rawValue)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .leading)

            
           

            Spacer()
            if errorVM.isLoading {
                LoadingView(isLoading: $errorVM.loaderLoading, size: 20)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                
                Button {
                    switch emailViewType {
                    case .forgotPass:
                        vm.forgotPassApiCall(method: .forgotPassEmail, httpMethod: .POST, data: vm.getData(method: .forgotPassEmail))
                    case .emailVerification:
                        vm.verifyPhnEmailApiCall(method: .emailActivation, httpMethod: .POST, data: [Constants.DictionaryForApiCall.email: vm.email])
                    }
                    
                } label: {
                    ButtonView(buttonName: vm.isNewUser ? Constants.ButtonsTitle.next : Constants.ButtonsTitle.done
                               ,
                               border    : false)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill((emailViewType == .forgotPass ? (!vm.emailValid.isEmpty || vm.forgotPassEmail.isEmpty) : vm.email.isEmpty) ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                        )
                }
                .disabled(emailViewType == .forgotPass ? (!vm.emailValid.isEmpty || vm.forgotPassEmail.isEmpty) : vm.email.isEmpty)
            }
        }
        
        .padding()
        .onAppear{
            vm.emailValid = ""
        }
        .onChange(of: vm.forgotPassEmail) { _ in
            if !vm.forgotPassEmail.isValidEmail() {
                vm.emailValid = Constants.ValidationsMsg.invalidEmpty
            } else {
                vm.emailValid = ""
            }
        }
        .alert("", isPresented: $vm.toDisplayEmailActivation, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) {
                self.dismiss()
            }
        }, message: {
            Text(vm.phnEmailVerificationResponse.status.message ?? "")
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

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView(emailViewType: .forgotPass)
            .environmentObject(AuthViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
    }
}
