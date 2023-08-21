//
//  MyRidesCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 13/06/23.
//

import SwiftUI

struct RidesBookedCard: View {
    
    @EnvironmentObject var vm: AuthViewModel
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    @State var bookingType: (String, Color) = ("", Color.white)
    
    var array: RideElement
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 7){
                HStack{
                    Group{
                        Text(array.ride.source.capitalized)
                        Image(systemName: Constants.Images.bigRightArrow)
                        Text(array.ride.destination.capitalized)
                            
                    }
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16, weight: .semibold ,design: .rounded))
                    Spacer()
                    
                    Text(bookingType.0).foregroundColor(bookingType.1)
                        .font(.system(size: 12, weight: .semibold ,design: .rounded))
                        .frame(width: 100, height: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .fill(bookingType.1.opacity(0.2))
                        )
                }
                .foregroundColor(.black)
                
                VStack(spacing: 5){
                    Text("Rs \(String(format: Constants.StringFormat.zeroDigit, array.ride.setPrice))")
                        .font(.system(size: 18, weight: .semibold ,design: .rounded))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    Group{
                        HStack{
                            Image(systemName: Constants.Images.calendar)
                            Text(DateTimeFormat.shared.dateFormat(date: array.ride.date))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Image(systemName: Constants.Images.clock)
                            if let sourceTime = array.ride.time, let destTime = array.reachTime {
                                Text("\(DateTimeFormat.shared.timeFormat(date: sourceTime, is24hrs: false, toNotReduce: false)) to \(DateTimeFormat.shared.timeFormat(date: destTime, is24hrs: false, toNotReduce: false))")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Image(systemName: Constants.Images.person)
                            Text("\(array.seat) ") +
                            Text(array.seat == 1 ? Constants.Description.seatBooked : Constants.Description.seatsBooked)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.system(size: 14 ,design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                .foregroundColor(Color(.darkGray))
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .onAppear{
            
            //vm.getProfileApiCall(method: .getDetails, httpMethod: .GET, data: [:])
            bookingType = myRidesVM.toSetBookingType(type: array.status, bookedTab: true)
        }
    }
}

struct RidesBookedCard_Previews: PreviewProvider {
    static var previews: some View {
        RidesBookedCard(array: RideElement(ride: GetPublishResponse.initialize, bookingID: 0, seat: 2, status: "confirm booking", reachTime: "", totalPrice: 0))
            .environmentObject(AuthViewModel())
            .environmentObject(MyRidesViewModel())
    }
}
