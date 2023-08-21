//
//  DobView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct DobView: View {
    
    @EnvironmentObject var vm: AuthViewModel
    @ObservedObject var navigationVM: NavigationViewModel
    
    var body: some View {
        VStack{
            GeometryReader{ _ in
                VStack(alignment: .leading){
                    Text(Constants.Headings.dobHeading)
                        .font(.system(size: 24, design: .rounded))
                        .bold()
                        .padding(.bottom, 40)
                    VStack{
                        TextViewFields(text: Constants.TextfieldPlaceholder.dob,
                                       selectedText: vm.userAuthData.user.dob,
                                       horizontalSpace: .Element(),
                                       isEmpty: vm.userAuthData.user.dob.isEmpty)
                            .foregroundColor(vm.userAuthData.user.dob.isEmpty ? Color(.gray).opacity(0.5) : .black)
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
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(vm.dobBtnDisable ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor)))
                                
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
                    VStack{
                        PickerView(isDatePicker : $vm.isDatePicker,
                                   toShowPicker : $vm.toShowPicker,
                                   myDate       : $vm.myDate,
                                   selectedIndex: $vm.selectedIndex)
                    }
                   
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
            .environmentObject(AuthViewModel())
    }
}
