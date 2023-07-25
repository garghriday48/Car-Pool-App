//
//  SocialButtonData.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import Foundation
import SwiftUI


struct TextFieldsData: Hashable {

    var binding: String
    var title: String
    var isPassOrNot: Bool
}

//extension TextFieldsData{
//    static var emailPasswordData = [TextFieldsData(binding: "", title: "Email", isPassOrNot: false),
//                                    TextFieldsData(binding: "", title: "Password", isPassOrNot: true)]
//}

struct OfferRideSelectorOptions: Identifiable{
    
    var id = UUID()
    var heading: String
    var text: String
    var isSelected: Bool
    var image: String
}


struct FilterData: Identifiable{
    var id = UUID()
    var name: String
    var image: String
    var isSelected: Bool
    var order: String
}


struct EditProfileOptions: Identifiable {
    
    var id = UUID()
    var heading: String
    var textField: String
    var type: TextFieldType
    var keyboardType: UIKeyboardType?
    var capitalizationType: TextInputAutocapitalization?
}

struct VehicleOptions: Identifiable {
    var id = UUID()
    var heading: String
    var textField: String
    var textFieldType: VehicleTextFieldType
    var keyboardType: UIKeyboardType?
    var capitalizationType: TextInputAutocapitalization?
}
