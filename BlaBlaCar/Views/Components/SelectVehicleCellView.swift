//
//  SelectVehicleCellView.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI

struct SelectVehicleCellView: View {
    
    var mainText: String
    var secondaryText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(mainText)
                .font(.title3)
            Text(secondaryText)
                .font(.subheadline)
            DividerCapsule(height: 2, color: Color(.systemGray3))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct SelectVehicleCellView_Previews: PreviewProvider {
    static var previews: some View {
        SelectVehicleCellView(mainText: "Nexon UP15 5432", secondaryText: "white")
    }
}
