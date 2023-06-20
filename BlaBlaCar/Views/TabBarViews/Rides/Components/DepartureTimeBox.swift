//
//  DepartureTimeBox.swift
//  BlaBlaCar
//
//  Created by Pragath on 18/05/23.
//

import SwiftUI

struct DepartureTimeBox: View {
    
    var image: String
    var text: String
    
    
    var body: some View {
        VStack{
            Image(systemName: image)
                .padding(.bottom, 1)
            Text(text)
        }
        .font(.subheadline)
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(Color(.darkGray))
        .background(Color(.systemGray6))
    }
}

struct DepartureTimeBox_Previews: PreviewProvider {
    static var previews: some View {
        DepartureTimeBox(image: "sunrise", text: "6:00 a.m")
    }
}
