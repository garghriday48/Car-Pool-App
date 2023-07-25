//
//  AvailableSeatsView.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI

struct AvailableSeatsView: View {
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    @Binding var toShowAvailableSeats: Bool
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            VStack{
                Capsule()
                    .frame(width: 40, height: 4)
                    .foregroundColor(Color(.systemGray3))
                HStack{
                    ZStack{
                        Button {
                            toShowAvailableSeats.toggle()
                        } label: {
                            Text(Constants.ButtonsTitle.close)
                                .font(.headline)
                                .foregroundColor(Color(.systemGray))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Text(Constants.Headings.availableSeats)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                Divider()
            }
            .padding(.vertical)
            ScrollView{
                ForEach(1..<9){seat in
                    VStack(alignment: .leading){
                        if seat == 1{
                            Text ("\(seat) \(Constants.Description.seat)")
                                
                         } else{
                             Text("\(seat) \(Constants.Description.seats)")
                                
                        }
                        DividerCapsule(height: 2, color: Color(.systemGray3))
                    }
                    .padding(.horizontal)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            carPoolVM.offerRideSelectorArray[1].text = "\(seat)"
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
    }
}

struct AvailableSeatsView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableSeatsView(carPoolVM: CarPoolRidesViewModel(), toShowAvailableSeats: .constant(false))
    }
}
