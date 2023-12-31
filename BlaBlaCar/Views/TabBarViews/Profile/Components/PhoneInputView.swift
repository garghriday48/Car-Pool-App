//
//  PhoneInputView.swift
//  BlaBlaCar
//
//  Created by Pragath on 20/06/23.
//

import SwiftUI

struct PhoneInputView: View {
    
    @EnvironmentObject var vm: AuthViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    @ObservedObject var profileVM: ProfileViewModel
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(Constants.Headings.enterPhone)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .bold()
                .padding(.bottom, 40)
            
            InputFields(text        : $vm.phoneNum,
                        title       : Constants.TextfieldPlaceholder.phoneNum,
                        isPassOrNot : false,
                        keyboardType: .numberPad,
                        capitalizationType: .never,
                        borderColor: vm.phoneNum.isEmpty ? .gray.opacity(0.6) : .black,
                        isDisabled: true)
            
            HStack{
                if !vm.phoneNumValid.isEmpty{
                    Image(systemName: Constants.Images.infoImage)
                }
                Text(vm.phoneNumValid)
                    .font(.system(size: 15))
            }
            .animation(.easeOut, value: vm.phoneVerificationSteps.rawValue)
            .padding(.leading)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            

            Spacer()
            Button {
                vm.verifyPhnEmailApiCall(method: .sentPhn, httpMethod: .POST, data: [Constants.DictionaryForApiCall.phnNumber: vm.phoneNum])
            } label: {
                ButtonView(buttonName   : Constants.ButtonsTitle.next,
                           border       : false)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(vm.phnNumBtnDisable ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                    )
                //.cornerRadius(50)
            }
            .disabled(vm.phnNumBtnDisable)
        }
        .padding()
        .onAppear{
            vm.updatingUserArray = profileVM.editProfileArray
            vm.phoneNum = vm.userData?.status.data?.phone_number ?? ""
        }
        .onChange(of: vm.phoneNum) { _ in
            vm.toValidatePhoneNum()
        }
    }
}

struct PhoneInputView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneInputView(profileVM: ProfileViewModel())
            .environmentObject(AuthViewModel())
    }
}
