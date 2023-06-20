//
//  DobView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct DobView: View {
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @ObservedObject var navigationVM: NavigationViewModel
    
    var body: some View {
        VStack{
            GeometryReader{ _ in
                VStack(alignment: .leading){
                    Text(Constants.Headings.dobHeading)
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 40)
                    VStack{
                        TextViewFields(text: vm.userAuthData.user.dob.isEmpty ? Constants.TextfieldPlaceholder.dob : vm.userAuthData.user.dob)
                            .foregroundColor(vm.userAuthData.user.dob.isEmpty ? Color(.gray).opacity(0.6) : .black)
                    }
                    .onTapGesture {
                        withAnimation{
                            vm.toShowPicker.toggle()
                        }
                    }
                    
                    Spacer()
                    VStack{
                        Button {
                            vm.signUpViews = .genderView
                        } label: {
                            ButtonView(buttonName   : Constants.ButtonsTitle.next,
                                       border       : false)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(vm.dobBtnDisable ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor)))
                                
                            //.cornerRadius(50)
                        }
                        .disabled(vm.dobBtnDisable)
                        Button {
                            vm.signUpViews = .fullNameView
                        } label: {
                            ButtonView(buttonName   : Constants.ButtonsTitle.back,
                                       border       : true)
                        }
                    }
                    .padding(.bottom, vm.toShowPicker ? 250 : 10)
                }
                .onAppear{
                    vm.isDatePicker = true
                }
                .padding(.horizontal)
                if vm.toShowPicker == true{
                    PickerView(isDatePicker : $vm.isDatePicker,
                               toShowPicker : $vm.toShowPicker,
                               myDate       : $vm.myDate,
                               selectedIndex: $vm.selectedIndex)
                }
            }
        }
        .onChange(of: vm.myDate, perform: { _ in
            vm.userAuthData.user.dob = vm.myDate.formatted(date: .abbreviated, time: .omitted)
        })
        .onDisappear{
            vm.toShowPicker = false
        }
    }
}

struct DobView_Previews: PreviewProvider {
    static var previews: some View {
        DobView(navigationVM: NavigationViewModel())
            .environmentObject(SignInSignUpViewModel())
    }
}
