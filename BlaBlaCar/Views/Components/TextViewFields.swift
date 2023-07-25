//
//  TextViewFields.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct TextViewFields: View {
    
    var text: String
    var selectedText: String
    var horizontalSpace: Edge.Set
    var isEmpty: Bool
    
    var body: some View {

        ZStack (alignment: .leading) {
            Text(text)
                .font(.system(size: 16, design: .rounded))
                .foregroundColor(.black.opacity(0.5))
                .padding(.horizontal, self.isEmpty ? 0 : 10)
                .background(Color.white)
                .offset(y: self.isEmpty ? 0 : -28)
                .scaleEffect(self.isEmpty ? 1 : 0.9, anchor: .leading)
                .padding(horizontalSpace)
            
            if !isEmpty {
                Text(selectedText)
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.black)
                    .padding(horizontalSpace)
                
            }
        }
        .frame(height: 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .animation(.easeOut, value: !self.isEmpty)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(self.isEmpty ? .black.opacity(0.5) : .black, lineWidth: 1)
        )
        .padding(.trailing, 8)
    }
}

struct TextViewFields_Previews: PreviewProvider {
    static var previews: some View {
        TextViewFields(text: "dob", selectedText: "we", horizontalSpace: .horizontal, isEmpty: true)
    }
}
