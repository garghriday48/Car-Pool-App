//
//  NumOfSeatsView.swift
//  BlaBlaCar
//
//  Created by Pragath on 02/06/23.
//

import SwiftUI

struct NumOfSeatsView: View {
    
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text(Constants.Headings.numOfSeats)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.gray)
            HStack(spacing: 20){
                Image(systemName: Constants.Images.seat)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .bold()
                Text(text)
                    .font(.system(size: 16, design: .rounded))
            }
            .font(.title3)
            DividerCapsule(height: 1, color: .gray.opacity(0.3))
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct NumOfSeatsView_Previews: PreviewProvider {
    static var previews: some View {
        NumOfSeatsView(text: "1")
    }
}
