//
//  SeatSelectorView.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct SeatSelectorView: View {
    @Binding var toShowSeatSelector: Bool
    @Binding var value: Int
    
    @EnvironmentObject var carPoolVM: CarPoolRidesViewModel
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
                            toShowSeatSelector.toggle()
                            value = carPoolVM.rideSearchData.passCount
                        } label: {
                            Text(Constants.ButtonsTitle.close)
                                .font(.headline)
                                .foregroundColor(Color(.systemGray))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Text(Constants.Headings.selectSeats)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                Divider()
                HStack{
                    Button {
                        value -= 1
                    } label: {
                        Image(systemName: Constants.Images.minusCircle)
                            .resizable()
                            .foregroundColor(value <= 0 ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                            .frame(width: 40, height: 40)
                        
                    }
                    .disabled(value <= 0)
                    Spacer()
                    VStack{
                        Text("\(value)")
                            .font(.largeTitle)
                        Text(Constants.Description.seats)
                            .foregroundColor(Color(.darkGray))
                        
                    }
                    Spacer()
                    Button {
                        value += 1
                    } label: {
                        Image(systemName: Constants.Images.plusCircle)
                            .resizable()
                            .foregroundColor(value >= 8 ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                            .frame(width: 40, height: 40)
                        
                    }
                    .disabled(value >= 8)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    carPoolVM.rideSearchData.passCount = carPoolVM.numOfSeats
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ButtonView(buttonName: Constants.ButtonsTitle.confirmSeats , border: true)
                }
                .padding()

            }
            .padding(.vertical)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
    }
}

struct SeatSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SeatSelectorView(toShowSeatSelector: .constant(false), value: .constant(0))
    }
}
