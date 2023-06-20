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
                        .font(.title3)
                        .foregroundColor(.primary)
                    Text(secondaryText)
                        .font(.subheadline)
                        .foregroundColor(Color(.darkGray))

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: Constants.Images.rightArrow)
                    .foregroundColor(.primary)
            }
            DividerCapsule(height: 2, color: Color(.systemGray3))
        }
        .padding()
    }
}

struct ProfileOptionsCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileOptionsCellView(mainText: "Account settings", secondaryText: "Notifications, password and more")
    }
}
