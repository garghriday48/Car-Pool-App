//
//  ProfileTextField.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import SwiftUI

struct ProfileTextField: View {
    
    @ObservedObject var profileVM: ProfileViewModel
    @ObservedObject var vm: AuthViewModel
    
    @Binding var textField: String
    
    var textFieldType: TextFieldType?
    var vehicleTextFieldType: VehicleTextFieldType?
    var heading: String
    var keyboardType: UIKeyboardType
    var capitalizationType: TextInputAutocapitalization
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20){

            HStack{
                switch textFieldType {
                case .firstName, .secondName , .email, .phnNum:
                    InputFields(text: $textField,
                                title: heading,
                                isPassOrNot: false,
                                keyboardType: keyboardType,
                                capitalizationType: capitalizationType,
                                borderColor: textField.isEmpty ? .black.opacity(0.5) : .black)
                        .onAppear{
                            switch textFieldType{
                            case .firstName: textField = profileVM.firstName
                            case .secondName: textField = profileVM.lastName
                            case .email: textField = profileVM.email
                            case .phnNum: textField = profileVM.phnNumber
                            case .dob, .gender, .none: break
                            }
                        }
                        .onChange(of: textField) { _ in
                            vm.toValidateProfileFields()
                        }
                    Spacer()
                case .gender:
                        ZStack(alignment: .trailing){
                            TextViewFields(text: Constants.TextfieldPlaceholder.gender,
                                           selectedText: profileVM.gender,
                                           horizontalSpace: .Element(),
                                           isEmpty: profileVM.gender.isEmpty)
                            .onAppear{
                                textField = profileVM.gender
                            }
                            .onChange(of: profileVM.gender) { _ in
                                textField = profileVM.gender
                            }
                             DropDownLabel()
                                .offset(x: -18)
                            }
                        .onTapGesture {
                            profileVM.toShowPicker = true
                            profileVM.isDatePicker = false
                        }
                        .padding(.top, 1)
                    
                case .dob:
                    ZStack(alignment: .trailing){
                        TextViewFields(text: Constants.TextfieldPlaceholder.dob,
                                       selectedText: profileVM.dob,
                                       horizontalSpace: .Element(),
                                       isEmpty: profileVM.dob.isEmpty)
                        
                        .onAppear{
                            textField = profileVM.dob
                        }
                        .onChange(of: profileVM.dob) { _ in
                            textField = profileVM.dob
                        }
                        DropDownLabel()
                           .offset(x: -18)
                    }
                    .onTapGesture {
                        profileVM.toShowPicker = true
                        profileVM.isDatePicker = true
                    }
                    .padding(.top, 1)

                case .none:
                    EmptyView()
                }
                
                if profileVM.isVehicleViewSelected {
                    switch vehicleTextFieldType {
                    case .name, .brand, .number:
                        InputFields(text: $textField,
                                    title: heading,
                                    isPassOrNot: false,
                                    keyboardType: keyboardType,
                                    capitalizationType: capitalizationType,
                                    borderColor: textField.isEmpty ? .black.opacity(0.5) : .black)
                            .onAppear{
                                switch vehicleTextFieldType {
                                case .name: textField = profileVM.vehicleName
                                case .brand: textField = profileVM.vehicleBrand
                                case .number: textField = profileVM.vehicleNumber
                                case .none, .country, .vehicleType, .year, .color: break
                                }
                            }
                        Spacer()
                    case .country:
                        ZStack(alignment: .trailing){
                            TextViewFields(text: Constants.TextfieldPlaceholder.country,
                                           selectedText: profileVM.country,
                                           horizontalSpace: .Element(),
                                           isEmpty: profileVM.country.isEmpty)
                            .onAppear{
                                textField = profileVM.country
                            }
                            .onChange(of: profileVM.country) { _ in
                                textField = profileVM.country
                            }
                                DropDownLabel()
                                    .offset(x: -18)
                        }
                        .onTapGesture {
                            profileVM.vehicleOptionSelector = vehicleTextFieldType!
                            profileVM.toShowVehicleOptionsList.toggle()
                        }
                        .padding(.top,1)
                        
                    case .vehicleType:
                        ZStack(alignment: .trailing){
                            TextViewFields(text: Constants.TextfieldPlaceholder.type,
                                           selectedText: profileVM.vehicleType,
                                           horizontalSpace: .Element(),
                                           isEmpty: profileVM.vehicleType.isEmpty)
                            .onAppear{
                                textField = profileVM.vehicleType
                            }
                            .onChange(of: profileVM.vehicleType) { _ in
                                textField = profileVM.vehicleType
                            }
                            
                            DropDownLabel()
                                .offset(x: -18)
                        }
                        .onTapGesture {
                            profileVM.vehicleOptionSelector = vehicleTextFieldType!
                            profileVM.toShowVehicleOptionsList.toggle()
                        }
                        .padding(.top,1)
                    case .year:
                        ZStack(alignment: .trailing){
                            TextViewFields(text: Constants.TextfieldPlaceholder.year,
                                           selectedText: profileVM.vehicleYear,
                                           horizontalSpace: .Element(),
                                           isEmpty: profileVM.vehicleYear.isEmpty)
                            .onAppear{
                                textField = profileVM.vehicleYear
                            }
                            .onChange(of: profileVM.vehicleYear) { _ in
                                textField = profileVM.vehicleYear
                            }
                            
                            DropDownLabel()
                                .offset(x: -18)
                        }
                        .onTapGesture {
                            profileVM.vehicleOptionSelector = vehicleTextFieldType!
                            profileVM.toShowVehicleOptionsList.toggle()
                        }
                        .padding(.top, 1)
                    case .color:
                        ZStack(alignment: .trailing){
                            TextViewFields(text: Constants.TextfieldPlaceholder.color,
                                           selectedText: profileVM.vehicleColor,
                                           horizontalSpace: .Element(),
                                           isEmpty: profileVM.vehicleColor.isEmpty)
                            .onAppear{
                                textField = profileVM.vehicleColor
                            }
                            .onChange(of: profileVM.vehicleColor) { _ in
                                textField = profileVM.vehicleColor
                            }
                            
                         DropDownLabel()
                            .offset(x: -18)
                        }
                        .onTapGesture {
                            profileVM.vehicleOptionSelector = vehicleTextFieldType!
                            profileVM.toShowVehicleOptionsList.toggle()
                        }
                        .padding(.top, 1)
                    case .none:
                        EmptyView()
                    }
                }
            }
            .padding(.bottom)
            
        }
        .font(.title3)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProfileTextField_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTextField(profileVM: ProfileViewModel(), vm: AuthViewModel(), textField: .constant(""), textFieldType: .dob, heading: "Name", keyboardType: .default, capitalizationType: .never)
    }
}


struct DropDownText: View {
    
    var text: String
    var condition: Bool
    var body: some View {
        Text(text)
            .foregroundColor(condition ? Color(.systemGray3) : .black)
    }
}

struct DropDownLabel: View {
    var body: some View {
        Image(systemName: Constants.Images.downArrow)
            .font(.system(size: 14, design: .rounded))
            .foregroundColor(Color(.darkGray))
            
    }
}
