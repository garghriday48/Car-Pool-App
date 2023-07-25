//
//  ParameterSelector.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI

struct ParameterSelector: View {
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    var heading: String
    var text: String
    var image: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text(heading)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.gray)
            HStack(spacing: 7){
                Image(systemName: image)
                Text(text)
                Spacer()
                Image(systemName: Constants.Images.downArrow)
            }
            .font(.system(size: 16, design: .rounded))
            DividerCapsule(height: 1, color: .gray.opacity(0.3))
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

}

struct ParameterSelector_Previews: PreviewProvider {
    static var previews: some View {
        ParameterSelector(carPoolVM: CarPoolRidesViewModel(), heading: "Available seats", text: "fwewef", image: Constants.Images.car)
    }
}
