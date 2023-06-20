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
                .font(.subheadline)
                .foregroundColor(Color(.darkGray))
            HStack(spacing: 20){
                Image(systemName: Constants.Images.calendar)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .bold()
                Text(text)
            }
            .font(.title3)
            DividerCapsule(height: 4, color: Color(.systemGray3))
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct DateSelector_Previews: PreviewProvider {
    static var previews: some View {
        DateSelector(heading: "", text: "May 24, 2023")
    }
}
