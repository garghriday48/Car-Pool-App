//
//  ProfileTextField.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import SwiftUI

struct ProfileTextField: View {
    
    @ObservedObject var profileVM: ProfileViewModel
    @ObservedObject var vm: SignInSignUpViewModel
    
    @Binding var textField: String
    
    var textFieldType: TextFieldType?
    var vehicleTextFieldType: VehicleTextFieldType?
    var heading: String
    var keyboardType: UIKeyboardType
    var capitalizationType: TextInputAutocapitalization
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10){
            Text(heading)
                .foregroundColor(Color(.darkGray))

            HStack{
                switch textFieldType {
                case .firstName, .secondName , .email, .phnNum:
                    TextField(heading, text: $textField)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(capitalizationType)
                        .foregroundColor(.black)
                        .autocorrectionDisabled()
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
                    Image(systemName: Constants.Images.pencil)
                        .foregroundColor(Color(.darkGray))
                        .padding(.leading)
                case .gender:
                    DropDownText(text: profileVM.gender.isEmpty ? Constants.TextfieldPlaceholder.dob : profileVM.gender, condition: profileVM.gender.isEmpty)
                        .onAppear{
                            textField = profileVM.gender
                        }
                        .onChange(of: profileVM.gender) { _ in
                            textField = profileVM.gender
                        }
                    Spacer()
                    Button {
                        profileVM.toShowPicker = true
                        profileVM.isDatePicker = false
                    } label: {
                        DropDownLabel()
                    }
                case .dob:
                    DropDownText(text: profileVM.dob.isEmpty ? Constants.TextfieldPlaceholder.dob : profileVM.dob, condition: profileVM.dob.isEmpty)
                        .onAppear{
                            textField = profileVM.dob
                        }
                        .onChange(of: profileVM.dob) { _ in
                            textField = profileVM.dob
                        }
                    Spacer()
                    Button {
                        profileVM.toShowPicker = true
                        profileVM.isDatePicker = true
                    } label: {
                        DropDownLabel()
                    }

                case .none:
                    EmptyView()
                }
                
                if profileVM.isVehicleViewSelected {
                    switch vehicleTextFieldType {
                    case .name, .brand, .number:
                        TextField(heading, text: $textField)
                            .keyboardType(keyboardType)
                            .foregroundColor(.black)
                            .autocorrectionDisabled()
                            .onAppear{
                                switch vehicleTextFieldType {
                                case .name: textField = profileVM.vehicleName
                                case .brand: textField = profileVM.vehicleBrand
                                case .number: textField = profileVM.vehicleNumber
                                case .none, .country, .vehicleType, .year, .color: break
                                }
                            }
                        Spacer()
                        Image(systemName: Constants.Images.pencil)
                            .foregroundColor(Color(.darkGray))
                            .padding(.leading)
                    case .country:
                        
                        DropDownText(text: profileVM.country.isEmpty ? Constants.TextfieldPlaceholder.country : profileVM.country, condition: profileVM.country.isEmpty)
                            .onAppear{
                                textField = profileVM.country
                            }
                            .onChange(of: profileVM.country) { _ in
                                textField = profileVM.country
                            }
                        Spacer()
                        Button {
                            profileVM.vehicleOptionSelector = vehicleTextFieldType!
                            profileVM.toShowVehicleOptionsList.toggle()
                        } label: {
                            DropDownLabel()
                        }
                    case .vehicleType:
                        DropDownText(text: profileVM.vehicleType.isEmpty ? Constants.TextfieldPlaceholder.type : profileVM.vehicleType, condition: profileVM.vehicleType.isEmpty)
                            .onAppear{
                                textField = profileVM.vehicleType
                            }
                            .onChange(of: profileVM.vehicleType) { _ in
                                textField = profileVM.vehicleType
                            }
                        Spacer()
                        Button {
                            profileVM.vehicleOptionSelector = vehicleTextFieldType!
                            profileVM.toShowVehicleOptionsList.toggle()
                        } label: {
                            DropDownLabel()
                        }
                    case .year:
                        DropDownText(text: profileVM.vehicleYear.isEmpty ? Constants.TextfieldPlaceholder.year : profileVM.vehicleYear, condition: profileVM.vehicleYear.isEmpty)
                            .onAppear{
                                textField = profileVM.vehicleYear
                            }
                            .onChange(of: profileVM.vehicleYear) { _ in
                                textField = profileVM.vehicleYear
                            }
                        Spacer()
                        Button {
                            profileVM.vehicleOptionSelector = vehicleTextFieldType!
                            profileVM.toShowVehicleOptionsList.toggle()
                        } label: {
                            DropDownLabel()
                        }
                    case .color:
                        DropDownText(text: profileVM.vehicleColor.isEmpty ? Constants.TextfieldPlaceholder.color : profileVM.vehicleColor, condition: profileVM.vehicleColor.isEmpty)
                            .onAppear{
                                textField = profileVM.vehicleColor
                            }
                            .onChange(of: profileVM.vehicleColor) { _ in
                                textField = profileVM.vehicleColor
                            }
                        Spacer()
                        Button {
                            profileVM.vehicleOptionSelector = vehicleTextFieldType!
                            profileVM.toShowVehicleOptionsList.toggle()
                        } label: {
                            DropDownLabel()
                        }
                    case .none:
                        EmptyView()
                    }
                }
            }
            .padding(.bottom, 5)
            DividerCapsule(height: 2, color: Color(.systemGray3))
        }
        .font(.title3)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProfileTextField_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTextField(profileVM: ProfileViewModel(), vm: SignInSignUpViewModel(), textField: .constant(""), textFieldType: .dob, heading: "Name", keyboardType: .default, capitalizationType: .never)
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
            .foregroundColor(Color(.darkGray))
            .padding(.leading)
    }
}
