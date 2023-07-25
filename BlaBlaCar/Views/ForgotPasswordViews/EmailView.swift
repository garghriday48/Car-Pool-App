//
//  EmailView.swift
//  BlaBlaCar
//
//  Created by Pragath on 21/06/23.
//

import SwiftUI

struct EmailView: View {
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text(Constants.Headings.enterEmail)
                .font(.system(size: 24,design: .rounded))
                .bold()
                .padding(.bottom, 40)
            InputFields(text        : $vm.forgotPassEmail,
                        title       : Constants.TextfieldPlaceholder.email,
                        isPassOrNot: false,
                        keyboardType: .emailAddress,
                        capitalizationType: .never,
                        borderColor: vm.forgotPassEmail.isEmpty ? .gray.opacity(0.5) : .black)
            
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
                    vm.forgotPassApiCall(method: .forgotPassEmail, httpMethod: .POST, data: vm.getData(method: .forgotPassEmail))
                } label: {
                    ButtonView(buttonName: vm.isNewUser ? Constants.ButtonsTitle.next : Constants.ButtonsTitle.next,
                               border    : false)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill((!vm.emailValid.isEmpty || vm.forgotPassEmail.isEmpty) ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                        )
                }
                .disabled(!vm.emailValid.isEmpty || vm.forgotPassEmail.isEmpty)
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
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
            .environmentObject(SignInSignUpViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
    }
}
