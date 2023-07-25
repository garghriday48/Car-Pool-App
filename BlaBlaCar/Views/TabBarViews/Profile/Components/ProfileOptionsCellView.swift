//
//  ProfileOptionsCellView.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import SwiftUI

struct ProfileOptionsCellView: View {
    var mainText: String
    var secondaryText: String
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 8){
                    
                    Text(mainText)
                        .font(.system(size: 16, design: .rounded)).bold()
                        .foregroundColor(.primary)
                    Text(secondaryText)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color(.darkGray))

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: Constants.Images.rightArrow)
                    .foregroundColor(.primary)
            }
            DividerCapsule(height: 1, color: .gray.opacity(0.3))
        }
        .padding([.horizontal, .top])
    }
}

struct ProfileOptionsCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileOptionsCellView(mainText: "Account settings", secondaryText: "Notifications, password and more")
    }
}
