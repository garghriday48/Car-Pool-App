//
//  BookedRideDetails.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/06/23.
//

import SwiftUI

struct BookedRideDetails: View {
    @Environment (\.presentationMode) var presentationMode
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    
    var array: RideElement
    
    var body: some View {
        VStack{
            HStack(spacing: 20){
                BackButton(image: Constants.Images.backArrow) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.title)
                .bold()
                Text(Constants.Headings.ridePlan)
                    .foregroundColor(.black)
                    .font(.title2)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            ScrollView{
                VStack(alignment: .leading){
                    Text(Constants.Headings.tripInfo)
                        .foregroundColor(.black)
                        .font(.title2)
                        .padding(.bottom)
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            Image(systemName: Constants.Images.calendar)
                            Text(DateTimeFormat.shared.dateFormat(date: array.ride.date))
                        }
                        .foregroundColor(Color(.darkGray))
                    }
                    .font(.title2)
                    .padding(.vertical)
                    
                    DividerCapsule(height: 2, color: Color(.systemGray3))
                    
                    
                    ZStack(alignment: .topLeading){
                        VStack(alignment: .leading, spacing: 30) {
                            
                            LocationInfo1(location: array.ride.source, exactLocation: array.ride.source, time: DateTimeFormat.shared.timeFormat(date:  array.ride.time ?? "", is24hrs: false))

                            
                            LocationInfo1(location: array.ride.destination, exactLocation: array.ride.destination, time: DateTimeFormat.shared.timeFormat(date:  array.reachTime ?? "", is24hrs: false))
                                .padding(.top)
                        }
                        .padding(.horizontal, 25)
                        PointToPointView(color: Color(.darkGray), height: 90)
                            .padding(.top, 10)
                        
                    }
                    .padding(.vertical)
                    .padding(.bottom, 40)
                    
                    DividerCapsule(height: 2, color: Color(.systemGray3))
                    
                        VStack(alignment: .leading){
                            HStack{
                                Text(Constants.Description.bookedSeats)
                                    .font(.title3)
                                    .foregroundColor(Color(.darkGray))
                                Spacer()
                                Text("\(array.seat)")
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                            .padding(.top, -10)
                            
                            HStack{
                                Text(Constants.Description.totalPrice)
                                    .font(.title3)
                                    .foregroundColor(Color(.darkGray))
                                Spacer()
                                Text(String(format: Constants.StringFormat.oneDigit, array.ride.setPrice))
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                            .padding(.top, -10)
                            
                            Text(Constants.Description.paymentType)
                                .font(.subheadline)
                                .foregroundColor(Color(.systemGray2))
                            
                        }
                        .padding(.vertical, 30)
                        
                        DividerCapsule(height: 2, color: Color(.systemGray3))
                    
                    
                    HStack {
                        AsyncImage(url: vm.profileResponse.imageUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    if vm.profileResponse.imageUrl == nil {
                                        Image(Constants.Images.person)
                                            .resizable()
                                            .scaledToFill()
                                    } else {
                                        ZStack {
                                            Color.gray.opacity(0.1)
                                            ProgressView()
                                        }
                                    }
                                }
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(lineWidth: 1)
                            }
                        VStack(alignment: .leading, spacing: 4){
                            if let firstName = vm.profileResponse.user?.first_name, let lastName = vm.profileResponse.user?.last_name {
                                Text(firstName + " " + lastName)
                                    .foregroundColor(.black)
                                    .font(.title3)
                            }
                            HStack{
                                Text("4.5")
                                Image(systemName: Constants.Images.starFilled)
                                Circle()
                                    .frame(width: 5, height: 5)
                                Text("27 Ratings")
                            }
                            .font(.subheadline)
                            .foregroundColor(Color(.darkGray))
                        }
                    }
                    .padding(.vertical)
                    VStack(alignment: .leading) {
                        Text(Constants.Headings.vehicleDetails).font(.title2)
                            .padding(.bottom)
                        Text(profileVM.getVehicleData.vehicleBrand).font(.title3) +
                        Text(" ") +
                        Text(profileVM.getVehicleData.vehicleName)
                            .font(.title3) +
                        Text(Constants.Description.dash + profileVM.getVehicleData.vehicleType)
                        
                        Text(Constants.Description.number + profileVM.getVehicleData.vehicleNumber)
                            .font(.subheadline)
                        Text(Constants.Description.color + profileVM.getVehicleData.vehicleColor).font(.subheadline)
                        DividerCapsule(height: 2, color: Color(.systemGray3))
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    if array.status == RideBookedType.CONFIRM.rawValue {
                        Button {
                            myRidesVM.cancelRideData.id = array.bookingID
                            myRidesVM.cancelBooking.toggle()
                        } label: {
                            Text(Constants.Headings.cancelBooking).bold().padding(.top)
                                .font(.title3)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.white)
                .cornerRadius(10)
                
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $carPoolVM.bookApiSuccess, destination: {
            BookedRideView(carPoolVM: carPoolVM)
        })
        .onAppear{
            vm.userId = array.ride.userID
            vm.getProfileApiCall(method: .getDetails, httpMethod: .GET, data: [:])
            
            profileVM.vehicleId = String(array.ride.vehicleID ?? 0)
            profileVM.getVehicleApiCall(method: .getVehicle, data: [:], httpMethod: .GET)
//            carPoolVM.bookRideData.passenger.publishId = array.publish.id
//            carPoolVM.bookRideData.passenger.seats = carPoolVM.numOfSeats
        }
        .onChange(of: myRidesVM.isRideCancelled) { _ in
            if myRidesVM.isRideCancelled {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct BookedRideDetails_Previews: PreviewProvider {
    static var previews: some View {
        BookedRideDetails(carPoolVM: CarPoolRidesViewModel(), array: RideElement(ride: GetPublishResponse(id: 0, source: "gwragar geGHEARGGREQBERGCWRQECQERW", destination: " gdgr hwthev ht j4thvt vt thv 4vtrvh trwb wth yv ", passengersCount: 0, addCity: nil, date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: nil, midSeat: nil, status: "", estimateTime: "", addCityLongitude: nil, addCityLatitude: nil), bookingID: 0, seat: 0, status: "", reachTime: ""))
            .environmentObject(SignInSignUpViewModel())
            .environmentObject(ProfileViewModel())
            .environmentObject(MyRidesViewModel())
        
    }
}

struct LocationInfo1: View {

        var location: String
        var exactLocation: String
        var time: String

        var body: some View {
            GeometryReader{ _ in
                VStack(alignment: .leading, spacing: 4){
                    Text(location)
                        .foregroundColor(.black)
                        .font(.title2)
                    Text(exactLocation)
                    Text(time)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(.darkGray))
            }
    }
}

