//
//  PriceEditView.swift
//  BlaBlaCar
//
//  Created by Pragath on 16/06/23.
//

import SwiftUI

struct PriceEditView: View {
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            HStack(spacing: 20){
                BackButton(image: Constants.Images.backArrow) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.title)
                .bold()
                Text(Constants.Headings.editPrice)
                    .foregroundColor(.black)
                    .font(.title2)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            
            VStack(alignment: .center){
                TextField("", text: $myRidesVM.updatedPrice)
                    .keyboardType(.numberPad)
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .multilineTextAlignment(.center)
                    
                    
                    
                DividerCapsule(height: 3, color: Color(.darkGray))
                    
            }
            .frame(width: 170)
            .padding()
            
            Button {
                myRidesVM.updateRideApiCall(dismissMethod: .itineraryDetails, method: .updatePublishedRide, httpMethod: .PUT, data: myRidesVM.toGetData(method: .price))
            } label: {
                ButtonView(buttonName: Constants.ButtonsTitle.done, border: true)
                    .padding(.horizontal)
            }

        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
        .onAppear{
            myRidesVM.updatedPrice = String(myRidesVM.publishResponseWithId.data.setPrice)
        }
    }
}

struct PriceEditView_Previews: PreviewProvider {
    static var previews: some View {
        PriceEditView()
            .environmentObject(MyRidesViewModel())
    }
}
