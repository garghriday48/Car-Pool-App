//
//  BookedRideView.swift
//  BlaBlaCar
//
//  Created by Pragath on 13/06/23.
//

import SwiftUI

struct BookedRideView: View {
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    @EnvironmentObject var navigationVM: NavigationViewModel
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            
            BackButton(image: Constants.Images.backArrow) {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .bold()
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
            
            VStack {
                Image(systemName: Constants.Images.checkmarkSeal)
                   .font(.system(size: 64))
                   .foregroundColor(Color(Color.redColor))
               
                Text(Constants.Headings.rideBooked)
                   .font(.headline)
                   .padding(.top, 10)
           }
            Button {
                navigationVM.pop(to: .TabBarPage)
                carPoolVM.resetSearchRideValues()
            } label: {
                ButtonView(buttonName: Constants.ButtonsTitle.done, border: true)
            }
            .padding()

        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
    }
}

struct BookedRideView_Previews: PreviewProvider {
    static var previews: some View {
        BookedRideView(carPoolVM: CarPoolRidesViewModel())
    }
}
