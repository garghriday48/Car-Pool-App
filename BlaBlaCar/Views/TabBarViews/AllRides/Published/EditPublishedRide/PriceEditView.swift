//
//  PriceEditView.swift
//  BlaBlaCar
//
//  Created by Pragath on 16/06/23.
//

import SwiftUI

struct PriceEditView: View {
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    @State var isDisabled = false
    
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
            .disabled(isDisabled)
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
        .onAppear{
            myRidesVM.updatedPrice = String(format: Constants.StringFormat.zeroDigit, myRidesVM.publishResponseWithId.data.setPrice)
        }
        .onChange(of: myRidesVM.updatedPrice) { newValue in
            if newValue.count > 8 {
                myRidesVM.updatedPrice = String(newValue.prefix(8))
                
            }
            if !newValue.onlyNum(){
                myRidesVM.updatedPrice = ""
                isDisabled = true
            } else {
                isDisabled = false
            }
            
        }
    }
}

struct PriceEditView_Previews: PreviewProvider {
    static var previews: some View {
        PriceEditView()
            .environmentObject(MyRidesViewModel())
    }
}
