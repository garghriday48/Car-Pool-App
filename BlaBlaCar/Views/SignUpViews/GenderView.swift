//
//  GenderView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct GenderView: View {
    
    var genderArray = ["Male", "Female", "Other"]
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @ObservedObject var navigationVM: NavigationViewModel
    
    var body: some View {
        VStack{
            GeometryReader{ _ in
                VStack(alignment: .leading) {
                    
                    Text(Constants.Headings.genderHeading)
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 40)
                    VStack{
                        TextViewFields(text: vm.selectedIndex == -1 ? Constants.TextfieldPlaceholder.gender : genderArray[vm.selectedIndex])
                            .foregroundColor(vm.selectedIndex == -1 ? Color(.gray).opacity(0.6) : .black)
                    }
                    .onTapGesture {
                        withAnimation{
                            vm.toShowPicker.toggle()
                        }
                    }
                    Spacer()
                    if vm.isLoading{
                        LoadingView(isLoading: $vm.isLoading)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Button {
                            vm.apiCall(method: .signUp, httpMethod: .POST, data: vm.getData(method: .signUp))
                        } label: {
                            ButtonView(buttonName   : Constants.ButtonsTitle.done,
                                       border       : false)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(vm.genderBtnDisable ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                            )
                            
                        }
                        .disabled(vm.genderBtnDisable)
                    }
                    Button {
                        vm.signUpViews = .dobView
                    } label: {
                        ButtonView(buttonName   : Constants.ButtonsTitle.back,
                                   border       : true)
                    }
                }
                
                .padding(.bottom, vm.toShowPicker ? 240 : 10)
                .onAppear{
                    vm.isDatePicker = false
                }
                .padding()
                if vm.toShowPicker == true{
                    PickerView(isDatePicker : $vm.isDatePicker,
                               toShowPicker : $vm.toShowPicker,
                               myDate       : $vm.myDate,
                               selectedIndex: $vm.selectedIndex)
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: vm.selectedIndex, perform: { _ in
            vm.userAuthData.user.title = genderArray[vm.selectedIndex]
        })
        .onDisappear{
            vm.toShowPicker = false
        }
    }
}

struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        GenderView(navigationVM: NavigationViewModel())
            .environmentObject(SignInSignUpViewModel())
    }
}
