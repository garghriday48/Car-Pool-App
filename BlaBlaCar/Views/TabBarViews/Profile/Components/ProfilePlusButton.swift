//
//  ProfilePlusButton.swift
//  BlaBlaCar
//
//  Created by Pragath on 22/05/23.
//

import SwiftUI

struct ProfilePlusButton: View {
    
    var image: String
    var name: String
    
    var body: some View {
        HStack{
            Image(systemName: image)
            Text(name)
        }
        .font(.system(size: 16, design: .rounded))
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color(Color.redColor))
    }
}

struct ProfilePlusButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePlusButton(image: "plus.circle", name: "Confirm email")
    }
}
