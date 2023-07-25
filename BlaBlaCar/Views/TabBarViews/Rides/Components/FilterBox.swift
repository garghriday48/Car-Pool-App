//
//  FilterBox.swift
//  BlaBlaCar
//
//  Created by Pragath on 18/05/23.
//

import SwiftUI

struct FilterBox: View {
    
    var name: String
    var image: String
    var isSelected: Bool
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7){
            HStack{
                Image(systemName: image)
                Text(name)
            }
        }
        .font(.system(size: 14, weight: .bold, design: .rounded))
        .fontWeight(.bold)
        .foregroundColor(isSelected ? Color(Color.redColor) : Color(.darkGray))
        .padding(10)
        .overlay(
                Rectangle()
                    .stroke(isSelected ? Color(Color.redColor) : Color(.darkGray), lineWidth: 2)
            )
    }
}

struct FilterBox_Previews: PreviewProvider {
    static var previews: some View {
        FilterBox(name: "Lowest price", image: "hourglass", isSelected: true)
    }
}
