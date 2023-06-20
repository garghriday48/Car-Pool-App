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
                .font(.subheadline)
                .foregroundColor(Color(.darkGray))
            HStack(spacing: 20){
                Image(systemName: Constants.Images.seat)
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

struct NumOfSeatsView_Previews: PreviewProvider {
    static var previews: some View {
        NumOfSeatsView(text: "1")
    }
}
