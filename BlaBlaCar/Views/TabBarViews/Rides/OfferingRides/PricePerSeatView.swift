//
//  PricePerSeatView.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI

struct PricePerSeatView: View {
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    @Binding var toShowSeatPrice: Bool
    @State var price = String()
    
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
                            toShowSeatPrice.toggle()
                            carPoolVM.offerRideSelectorArray[2].text = String()
                        } label: {
                            Text(Constants.ButtonsTitle.close)
                                .font(.headline)
                                .foregroundColor(Color(.systemGray))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Text(Constants.Headings.perSeatPrice)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                Divider()
            }
            .padding(.vertical)
            
            VStack{
                TextField("", text: $price)
                    .keyboardType(.numberPad)
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .multilineTextAlignment(.center)
                DividerCapsule(height: 3, color: Color(.darkGray))
            }
            .frame(width: 170, alignment: .center)
            .padding()
            Button {
                carPoolVM.offerRideSelectorArray[2].text = price
                presentationMode.wrappedValue.dismiss()
            } label: {
                ButtonView(buttonName: Constants.ButtonsTitle.done, border: true)
                    .padding(.horizontal)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
    }
}

struct PricePerSeatView_Previews: PreviewProvider {
    static var previews: some View {
        PricePerSeatView(carPoolVM: CarPoolRidesViewModel(), toShowSeatPrice: .constant(false))
    }
}
