//
//  PasswordInfoView.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

struct InfoTextView: View {
    
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(.black.opacity(0.5))
            .font(.system(size: 14, design: .rounded))
            .padding(.top, 20)
    }
}
