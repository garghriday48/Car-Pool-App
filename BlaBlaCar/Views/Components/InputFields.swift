//
//  SecureInputField.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

struct InputFields: View {
    
    @Binding var text: String
    @State var isSecured: Bool = true
    var title: String
    var isPassOrNot: Bool
    var keyboardType: UIKeyboardType

    var body: some View {
        ZStack(alignment: .trailing) {
            if isPassOrNot {
                Group {
                    if isSecured {
                        SecureField(title, text: $text)
                            .autocorrectionDisabled()
                            .keyboardType(keyboardType)
                    } else {
                        TextField(title, text: $text)
                            .autocorrectionDisabled()
                            .keyboardType(keyboardType)
                    }
                }
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? Constants.Images.eyeClose : Constants.Images.eye)
                        //.accentColor(.gray)
                        .padding(.trailing,-20)
                }
            } else {
                TextField(title, text: $text)
                    .autocorrectionDisabled()
                    .keyboardType(keyboardType)
            }
        }
        //.foregroundColor(.black)
        .padding()
        .padding(.trailing,20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
            )
        .shadow(radius: 2)
    }
}

