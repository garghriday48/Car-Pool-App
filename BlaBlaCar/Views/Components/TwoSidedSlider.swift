//
//  TwoSidedSlider.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import SwiftUI

struct TwoSidedSlider: View {
    
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    
    var body: some View {
        
        VStack{
            Text("$\(carPoolVM.getValue(value: (carPoolVM.minRidePrice / carPoolVM.totalWidth) * 2000, format: Constants.StringFormat.zeroDigit)) - $\(carPoolVM.getValue(value: (carPoolVM.maxRidePrice / carPoolVM.totalWidth) * 2000, format: Constants.StringFormat.zeroDigit)) ")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack(alignment: .leading) {
                
                Rectangle()
                    .fill(Color.black.opacity(0.20))
                    .frame(width: UIScreen.main.bounds.width - 40, height: 6)
                    
                
                Rectangle()
                    .fill(Color(Color.redColor))
                    .frame(width: carPoolVM.maxRidePrice - carPoolVM.minRidePrice, height: 6)
                    .offset(x: carPoolVM.minRidePrice + 20)
                    
                
                HStack(spacing: 0){
                    
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 20, height: 20)
                        .offset(x: carPoolVM.minRidePrice)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    
                                    if value.location.x >= 0 && value.location.x <= carPoolVM.maxRidePrice {
                                        carPoolVM.minRidePrice = value.location.x
                                    }
                                })
                        
                        
                        )
                    
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 20, height: 20)
                        .offset(x: carPoolVM.maxRidePrice)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    
                                    if value.location.x <= carPoolVM.totalWidth && value.location.x >= carPoolVM.minRidePrice {
                                        carPoolVM.maxRidePrice = value.location.x
                                    }
                                })
                        ) 
                }
            }
            HStack{
                Text(Constants.Description.rs0)
                Spacer()
                Text(Constants.Description.rs2000)
                
            }
            .font(.subheadline)
            .foregroundColor(Color(.darkGray))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct TwoSidedSlider_Previews: PreviewProvider {
    static var previews: some View {
        TwoSidedSlider(carPoolVM: CarPoolRidesViewModel())
    }
}
