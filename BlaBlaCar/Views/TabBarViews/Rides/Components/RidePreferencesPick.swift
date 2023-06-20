//
//  RidePreferencesPick.swift
//  BlaBlaCar
//
//  Created by Pragath on 18/05/23.
//

import SwiftUI

struct RidePreferencesPick: View {
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    var body: some View {
        HStack{
            Image(systemName: "bolt.fill")
                .font(.title2)
            Text("Instant approval")
            Spacer()
            Button {
                carPoolVM.bookInstantly.toggle()
            } label: {
                if !carPoolVM.bookInstantly {
                    Image(systemName: "circlebadge")
                        .font(.title2)
                } else {
                    Image(systemName: "circle.inset.filled")
                }
            }
        }
        .foregroundColor(Color(.darkGray))
    }
}

struct RidePreferencesPick_Previews: PreviewProvider {
    static var previews: some View {
        RidePreferencesPick(carPoolVM: CarPoolRidesViewModel())
    }
}
