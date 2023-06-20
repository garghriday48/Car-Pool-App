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
                    .font(.title3.bold())
                
                Text(secondayName)
                    .font(.caption)
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
