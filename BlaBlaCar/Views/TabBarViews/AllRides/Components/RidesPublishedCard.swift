//
//  RidesPublishedCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 13/06/23.
//

import SwiftUI

struct RidesPublishedCard: View {
    
    var array: GetPublishResponse
    
    @State var publishedType: (String, Color) = ("", Color.white)
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 7){
                HStack{
                    Text(array.source)
                        .lineLimit(2)
                    Image(systemName: Constants.Images.bigRightArrow)
                    Text(array.destination)
                        .lineLimit(2)
                    Spacer()
                    Text(publishedType.0).font(.caption).bold().foregroundColor(publishedType.1)
                        .frame(width: 100, height: 20)
                        .background(publishedType.1.opacity(0.2))
                }
                .foregroundColor(.black)
                .font(.title3)
                VStack(spacing: 5){
                    Text("Rs \(String(format: Constants.StringFormat.oneDigit, array.setPrice)) per seat")
                        .font(.headline).foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    HStack{
                        Image(systemName: Constants.Images.calendar)
                        Text(DateTimeFormat.shared.dateFormat(date: array.date))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Image(systemName: Constants.Images.clock)
                        if let sourceTime = array.estimateTime{
                            Text(DateTimeFormat.shared.timeFormat(date: sourceTime, is24hrs: true) + " hrs")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Image(systemName: Constants.Images.person)
                        Text("\(array.passengersCount) seats left")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .padding(.bottom)
                .foregroundColor(Color(.darkGray))
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .onAppear{
            publishedType = myRidesVM.toSetBookingType(type: array.status, bookedTab: false)
        }
    }
}

struct RidesPublishedCard_Previews: PreviewProvider {
    static var previews: some View {
        RidesPublishedCard(array: GetPublishResponse(id: 12, source: "Gurgoan", destination: "Meerut", passengersCount: 1, addCity: nil, date: "", time: "", setPrice: 0.0, aboutRide: nil, userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: nil, midSeat: nil, status: "", estimateTime: "", addCityLongitude: nil, addCityLatitude: nil))
    }
}
