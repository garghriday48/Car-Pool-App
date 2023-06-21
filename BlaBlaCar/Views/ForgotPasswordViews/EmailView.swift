//
//  EmailView.swift
//  BlaBlaCar
//
//  Created by Pragath on 21/06/23.
//

import SwiftUI

struct EmailView: View {
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text(Constants.Headings.enterEmail)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)
            InputFields(text        : $vm.forgotPassEmail,
                        title       : Constants.TextfieldPlaceholder.email,
                        isPassOrNot: false,
                        keyboardType: .emailAddress,
                        capitalizationType: .never)
            
            .padding(.bottom, (vm.emailValid.isEmpty) ? 20 : 0)

            HStack{
                if !vm.emailValid.isEmpty{
                    Image(systemName: Constants.Images.infoImage)
                }
                Text(vm.emailValid)
                    .font(.system(size: 15))
            }
            .animation(.easeOut, value: vm.forgotPasswordView.rawValue)
            .padding(.leading)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .leading)

            
           

            Spacer()
            if vm.isLoading {
                LoadingView(isLoading: $vm.loaderLoading)
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
            vm.forgotPassEmail = ""
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
    }
}
