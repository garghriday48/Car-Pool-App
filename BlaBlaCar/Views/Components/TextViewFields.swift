//
//  TextViewFields.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct TextViewFields: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .padding(.horizontal,20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white))
            .shadow(radius: 2)
    }
}

struct TextViewFields_Previews: PreviewProvider {
    static var previews: some View {
        TextViewFields(text: "")
    }
}
