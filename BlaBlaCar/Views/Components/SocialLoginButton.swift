//
//  SocialLoginButton.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

struct SocialLoginButton: View {
    var image: Image
    var text: Text
    var color: Color
    
    var body: some View {
        HStack {
            image
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.horizontal)
                
            text
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                
            Spacer()
        }
        .bold()
        .padding(15)
        .foregroundColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(color)
            )
        //.cornerRadius(50.0)
        //.shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
    }
}

