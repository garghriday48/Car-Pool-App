//
//  ButtonView.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

struct ButtonView: View {
    
        var buttonName: String
        var border: Bool
        var color: Color = Color(Color.redColor)
    
        var body: some View {
            if border == false{
                
                Text(buttonName)
                    .font(.system(size: 16, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    
            } else {
                Text(buttonName)
                    .font(.system(size: 16, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(color)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(color, lineWidth: 1)
                        )
                    
            }
    }
}

struct CarPoolButtonView: View {
    
    @Binding var isSelected: RideMethods
    var buttonName: String
    
    var body: some View {
        Text(buttonName)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 120, height: 5)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(isSelected == .bookingRide ? Color(Color.redColor) : Color(.systemGray3))
                )
    }
}


struct BackButton: View {
    
    var image: String
    let action: () -> Void
    var color: Color = .primary
   
    
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .foregroundColor(color)
        }
    }
}
