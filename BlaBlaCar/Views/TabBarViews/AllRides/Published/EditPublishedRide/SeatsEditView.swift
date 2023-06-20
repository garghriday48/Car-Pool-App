//
//  SeatsEditView.swift
//  BlaBlaCar
//
//  Created by Pragath on 16/06/23.
//

import SwiftUI

struct SeatsEditView: View {
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    @Environment (\.presentationMode) var presentationMode
    
    @Binding var value: Int
    
    
    var body: some View {
        VStack{
            HStack(spacing: 20){
                BackButton(image: Constants.Images.backArrow) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.title)
                .bold()
                Text(Constants.Headings.editSeats)
                    .foregroundColor(.black)
                    .font(.title2)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            
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
                myRidesVM.updateRideApiCall(dismissMethod: .seats, method: .updatePublishedRide, httpMethod: .PUT, data: myRidesVM.toGetData(method: .seats))
            } label: {
                ButtonView(buttonName: Constants.ButtonsTitle.confirmSeats , border: true)
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
    }
}

struct SeatsEditView_Previews: PreviewProvider {
    static var previews: some View {
        SeatsEditView(value: .constant(0))
    }
}
