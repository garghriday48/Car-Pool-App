//
//  FilterAndSortView.swift
//  BlaBlaCar
//
//  Created by Pragath on 18/05/23.
//

import SwiftUI

struct FilterAndSortView: View {
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    @Binding var toShowSelectVehicle: Bool
    
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
                            toShowSelectVehicle.toggle()
                        } label: {
                            Text(Constants.ButtonsTitle.close)
                                .font(.headline)
                                .foregroundColor(Color(.systemGray))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Text("Filters")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                Divider()
            }
            .padding(.vertical)
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        Text("Departure time")
                            .font(.title3)
                        HStack{
                            ForEach(0..<2){card in
                                DepartureTimeBox(image: DataArrays.departureTimeArray[card][0] , text: DataArrays.departureTimeArray[card][1])
                            }
                            .padding(3)
                        }
                        HStack{
                            ForEach(2..<4){card in
                                DepartureTimeBox(image: DataArrays.departureTimeArray[card][0] , text: DataArrays.departureTimeArray[card][1])
                            }
                            .padding(3)
                        }
                        .padding(.bottom)
                        DividerCapsule(height: 1, color: Color(.systemGray3))
                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        Text("Ride preferences")
                            .font(.title3)
                            .padding(.bottom)
                        RidePreferencesPick(carPoolVM: carPoolVM)
                            .padding(.bottom)
                        DividerCapsule(height: 1, color: Color(.systemGray3))
                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        Text("Price range")
                            .font(.title3)
                            .padding(.bottom)
                        
                        TwoSidedSlider(carPoolVM: carPoolVM)
                        
                        DividerCapsule(height: 1, color: Color(.systemGray3))
                    }
                    .padding()
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            DividerCapsule(height: 3, color: Color(.systemGray3))
            
            HStack{
                Button {
                    
                } label: {
                    VStack(alignment: .leading, spacing: 8){
                        HStack{
                            Text("Clear all")
                        }
                        .bold()
                        .foregroundColor(Color(Color.redColor))
                        .font(.title3)
                    }
                }
                Spacer()
                
                Button {
                    carPoolVM.filterAndSort.toggle()
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    ButtonView(buttonName: "Search", border: false)
                        .background(Color(Color.redColor))
                        .cornerRadius(50)
                        .frame(width: 170)
                }

                

            }
            .padding()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
    }
}

struct FilterAndSortView_Previews: PreviewProvider {
    static var previews: some View {
        FilterAndSortView(carPoolVM: CarPoolRidesViewModel(), toShowSelectVehicle: .constant(false))
    }
}
