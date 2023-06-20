//
//  FullNameVIew.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct FullNameView: View {
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @ObservedObject var navigationVM: NavigationViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text(Constants.Headings.fullNameHeading)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)
            InputFields(text        :$vm.userAuthData.user.firstName,
                        title       : Constants.TextfieldPlaceholder.firstName,
                        isPassOrNot : false,
                        keyboardType: .default)
                .padding(.bottom, !vm.firstNameValid.isEmpty ? 0 : 20)
            
            HStack{
                if !vm.firstNameValid.isEmpty{
                    Image(systemName: Constants.Images.infoImage)
                }
                Text(vm.firstNameValid)
                    .font(.system(size: 15))
            }
            .animation(.easeOut, value: vm.signUpViews.rawValue)
            .padding(.leading)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            InputFields(text        : $vm.userAuthData.user.lastName,
                        title       : Constants.TextfieldPlaceholder.secondName,
                        isPassOrNot : false,
                        keyboardType: .default)
            .padding(.bottom, !vm.lastNameValid.isEmpty ? 0 : 20)
            HStack{
                if !vm.lastNameValid.isEmpty{
                    Image(systemName: Constants.Images.infoImage)
                }
                Text(vm.lastNameValid)
                    .font(.system(size: 15))
            }
            .animation(.easeOut, value: vm.signUpViews.rawValue)
            .padding(.leading)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            InfoTextView(text: Constants.fullNameDesc)
            Spacer()
            Button {
                vm.signUpViews = .dobView
            } label: {
                ButtonView(buttonName   : Constants.ButtonsTitle.next,
                           border       : false)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(vm.fullNameBtnDisable ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                    )
                //.cornerRadius(50)
            }
            .disabled(vm.fullNameBtnDisable)
            Button {
                vm.signUpViews = .emailPasswordView
            } label: {
                ButtonView(buttonName   : Constants.ButtonsTitle.back,
                           border       : true)
            }
        }
        .padding()
        .onChange(of: vm.userAuthData.user.firstName) { _ in
            vm.toValidateName()
        }
        .onChange(of: vm.userAuthData.user.lastName, perform: { _ in
            vm.toValidateName()
        })
    }
}

struct FullNameView_Previews: PreviewProvider {
    static var previews: some View {
        FullNameView(navigationVM: NavigationViewModel())
            .environmentObject(SignInSignUpViewModel())
    }
}
