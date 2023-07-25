//
//  LocationCell.swift
//  BlaBlaCar
//
//  Created by Pragath on 24/05/23.
//

import SwiftUI

struct LocationCell: View {
    var name: String
    var secondayName: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: Constants.Images.location)
                .font(.title2)
                .foregroundColor(.gray)
            VStack(alignment: .leading, spacing: 6){
                Text(name)
                    .font(.system(size: 20, weight: .bold ,design: .rounded))
                
                Text(secondayName)
                    .font(.system(size: 14, weight: .semibold ,design: .rounded))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(name: "Mohali", secondayName: "Mohali, India")
    }
}
