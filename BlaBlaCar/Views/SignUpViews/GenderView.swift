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
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    var body: some View {
        VStack{
            GeometryReader{ _ in
                VStack(alignment: .leading) {
                    
                    Text(Constants.Headings.genderHeading)
                        .font(.system(size: 24, design: .rounded))
                        .bold()
                        .padding(.bottom, 40)
                    VStack{
                        TextViewFields(text: Constants.TextfieldPlaceholder.gender,
                                       selectedText: vm.userAuthData.user.title,
                                       horizontalSpace: .Element(),
                                       isEmpty: vm.selectedIndex == -1)
                            .foregroundColor(vm.userAuthData.user.dob.isEmpty ? Color(.gray).opacity(0.5) : .black)
                        
                    }
                    .onTapGesture {
                        withAnimation{
                            vm.selectedIndex = 0
                            vm.toShowPicker.toggle()
                        }
                    }
                    Spacer()
                    if errorVM.isLoading{
                        LoadingView(isLoading: $errorVM.isLoading, size: 20)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Button {
                            vm.apiCall(method: .signUp, httpMethod: .POST, data: vm.getData(method: .signUp))
                        } label: {
                            ButtonView(buttonName   : Constants.ButtonsTitle.done,
                                       border       : false)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
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
            .environmentObject(ResponseErrorViewModel.shared)
    }
}
