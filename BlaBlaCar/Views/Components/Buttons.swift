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
    
        var body: some View {
            if border == false{
                
                Text(buttonName)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    
            } else {
                Text(buttonName)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(Color.redColor))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(Color.redColor), lineWidth: 2)
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
   
    
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .foregroundColor(.primary)
        }
    }
}
