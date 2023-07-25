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
    @State var isDisabled = false
    
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
                            
                        } label: {
                            Text(Constants.ButtonsTitle.close)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color(Color.redColor))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Text(Constants.Headings.perSeatPrice)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
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
                    .padding(.top)
                    .multilineTextAlignment(.center)
                DividerCapsule(height: 1, color: Color(.black))
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
        .onChange(of: price) { newValue in
            if newValue.count > 6 {
                price = String(newValue.prefix(6))
                
            }
            if !newValue.onlyNum(){
                price = ""
                isDisabled = true
            } else {
                isDisabled = false
            }
            
        }
        .onAppear{
            price = carPoolVM.offerRideSelectorArray[2].text
        }
    }
}

struct PricePerSeatView_Previews: PreviewProvider {
    static var previews: some View {
        PricePerSeatView(carPoolVM: CarPoolRidesViewModel(), toShowSeatPrice: .constant(false))
    }
}
