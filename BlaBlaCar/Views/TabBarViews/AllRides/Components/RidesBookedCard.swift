//
//  MyRidesCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 13/06/23.
//

import SwiftUI

struct RidesBookedCard: View {
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    @State var bookingType: (String, Color) = ("", Color.white)
    
    var array: RideElement
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 7){
                HStack{
                    Text(array.ride.source)
                        .lineLimit(2)
                    Image(systemName: Constants.Images.bigRightArrow)
                    Text(array.ride.destination)
                        .lineLimit(2)
                    Spacer()
                    
                    Text(bookingType.0).font(.caption).bold().foregroundColor(bookingType.1)
                        .frame(width: 100, height: 20)
                        .background(bookingType.1.opacity(0.2))
                }
                .foregroundColor(.black)
                .font(.title3)
                VStack(spacing: 5){
                    Text("Rs \(String(format: Constants.StringFormat.oneDigit, array.ride.setPrice))")
                        .font(.headline).foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    HStack{
                        Image(systemName: Constants.Images.calendar)
                        Text(DateTimeFormat.shared.dateFormat(date: array.ride.date))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Image(systemName: Constants.Images.clock)
                        if let sourceTime = array.ride.time, let destTime = array.reachTime {
                            Text("\(DateTimeFormat.shared.timeFormat(date: sourceTime, is24hrs: false)) to \(DateTimeFormat.shared.timeFormat(date: destTime, is24hrs: false))")
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .padding(.bottom)
                .foregroundColor(Color(.darkGray))
//                DividerCapsule(height: 2, color: Color(.systemGray3))
//                HStack {
//                    AsyncImage(url: vm.profileResponse.imageUrl) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFill()
//                            } placeholder: {
//                                if vm.profileResponse.imageUrl == nil {
//                                    Image(Constants.Images.person)
//                                        .resizable()
//                                        .scaledToFill()
//                                } else {
//                                    ZStack {
//                                        Color.gray.opacity(0.1)
//                                        ProgressView()
//                                    }
//                                }
//                            }
//                        .clipShape(Circle())
//                        .frame(width: 60, height: 60)
//                        .overlay {
//                            Circle().stroke(lineWidth: 1)
//                        }
//                    VStack(alignment: .leading, spacing: 4){
//                        Text((vm.profileResponse.user?.first_name ?? "") + " " + (vm.profileResponse.user?.last_name ?? ""))
//                            .foregroundColor(.black)
//                            .font(.title3)
//                        HStack{
//                            Text("")
//                            Image(systemName: Constants.Images.starFilled)
//                            Circle()
//                                .frame(width: 5, height: 5)
//                            Text("27 Ratings")
//                        }
//                        .font(.subheadline)
//                        .foregroundColor(Color(.darkGray))
//
//                    }
//                }
//                .padding(.vertical)
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
        RidesBookedCard(array: RideElement(ride: GetPublishResponse(id: 12, source: "Gurgoan", destination: "Meerut", passengersCount: 1, addCity: nil, date: "", time: "", setPrice: 0.0, aboutRide: nil, userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: nil, midSeat: nil,  status: "", estimateTime: "", addCityLongitude: nil, addCityLatitude: nil), bookingID: 0, seat: 2, status: "confirm booking", reachTime: ""))
            .environmentObject(SignInSignUpViewModel())
            .environmentObject(MyRidesViewModel())
    }
}
