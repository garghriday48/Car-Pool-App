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
    var capitalizationType: TextInputAutocapitalization
    var borderColor: Color

    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 16, design: .rounded))
                .foregroundColor(.black.opacity(0.5))
                .padding(.horizontal, self.text.isEmpty ? 0 : 10)
                .background(Color.white)
                .offset(y: self.text.isEmpty ? 0 : -28)
                .scaleEffect(self.text.isEmpty ? 1 : 0.9, anchor: .leading)
            if isPassOrNot {
                HStack{
                    Group {
                        if isSecured {
                            SecureField("", text: $text)
                                .frame(height: 20)
                        } else {
                            TextField("", text: $text)
                                .frame(height: 20)
                        }
                    }
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.black)
                    .autocorrectionDisabled()
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(capitalizationType)
                    Spacer()
                    
                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: self.isSecured ? Constants.Images.eyeClose : Constants.Images.eye)
                            .foregroundColor(Color(Color.redColor))
                            .padding(.trailing,-20)
                        
                    }
                }
        
                
            } else {
                ZStack(alignment: .trailing){
                    TextField("", text: $text)
                        
                    if !self.text.isEmpty {
                        Button(action:
                        {
                            self.text = ""
                        })
                        {
                            Image(systemName: Constants.Images.crossFill)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        .padding(.trailing, -20)
                    }
                }
                .autocorrectionDisabled()
                .keyboardType(keyboardType)
                .textInputAutocapitalization(capitalizationType)
                .font(.system(size: 16, design: .rounded))
                .foregroundColor(.black)
                .frame(height: 20)
            }
        }
        .animation(.easeOut, value: !text.isEmpty)
        .padding()
        .padding(.trailing,20)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(borderColor, lineWidth: 1)
            )
    }
}

