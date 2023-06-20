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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text(heading)
                .font(.subheadline)
                .foregroundColor(Color(.darkGray))
            HStack{
                Text(text)
                    .font(.title3)
                Spacer()
                Image(systemName: Constants.Images.downArrow)
            }
            DividerCapsule(height: 2, color: Color(.systemGray3))
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

}

struct ParameterSelector_Previews: PreviewProvider {
    static var previews: some View {
        ParameterSelector(carPoolVM: CarPoolRidesViewModel(), heading: "Available seats", text: "fwewef")
    }
}
