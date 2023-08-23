//
//  RideDetailsView.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct RideDetailsView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    @Binding var array: DataArray
    
    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                BackButton(image: Constants.Images.backArrow, action: {
                    presentationMode.wrappedValue.dismiss()
                }, color: .white)
                .font(.system(size: 20, weight: .semibold ,design: .rounded))
                Text(Constants.Headings.rideDetails)
                    .font(.system(size: 22, weight: .semibold ,design: .rounded))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            .foregroundColor(.white)
            
            DetailsCard(carPoolVM: carPoolVM, isRideDetails: $carPoolVM.isRideDetails, isSeatSelected: $carPoolVM.isSeatSelected, NumOfSeatSelected: $carPoolVM.numOfSeats, array: $array)
            
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
    }
}

struct RideDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RideDetailsView(carPoolVM: CarPoolRidesViewModel(), array: .constant(DataArray(id: 0, name: "", reachTime: "", imageURL: nil, averageRating: nil, aboutRide: "", publish: PublishResponse(id: 0, source: "", destination: "", passengersCount: 0, addCity: "", date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: "", midSeat: "", selectRoute: SelectRoute(), status: "", estimateTime: "", addCityLongitude: 0.0, addCityLatitude: 0.0, distance: nil, bearing: nil))))
        }
    }
}
