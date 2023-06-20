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
            .font(.system(size: 18))
            .padding(.top, 20)
    }
}
