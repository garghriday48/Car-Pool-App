//
//  DateSelector.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct DateSelector: View {
    
    var heading: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text(heading)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.gray)
            HStack(spacing: 20){
                Image(systemName: Constants.Images.calendar)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .bold()
                Text(text)
            }
            .font(.system(size: 16, design: .rounded))
            DividerCapsule(height: 1, color: .gray.opacity(0.3))
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.horizontal, .top])
    }
}

struct DateSelector_Previews: PreviewProvider {
    static var previews: some View {
        DateSelector(heading: "", text: "May 24, 2023")
    }
}
