//
//  DetailsCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct DetailsCard: View {
    
    @EnvironmentObject var vm: SignInSignUpViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    @Binding var isRideDetails: Bool
    @Binding var isSeatSelected: Bool
    @Binding var NumOfSeatSelected: Int
    
    @Binding var array: DataArray
    
    var body: some View {
        VStack{
            ScrollView{
                VStack(alignment: .leading){
                    Text(Constants.Headings.tripInfo)
                        .foregroundColor(.black)
                        .font(.title2)
                        .padding(.bottom)
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            Image(systemName: Constants.Images.calendar)
                            Text(DateTimeFormat.shared.dateFormat(date: array.publish.date))
                        }
                        .foregroundColor(Color(.darkGray))
                        
                        HStack{
                            Image(systemName: Constants.Images.clock)
                            if let estimatedTime = array.publish.estimateTime {
                                Text(DateTimeFormat.shared.timeFormat(date: estimatedTime, is24hrs: true) + " hrs")
                            }
                        }
                        .foregroundColor(Color(.darkGray))
                    }
                    .font(.title2)
                    .padding(.vertical)
                    
                    DividerCapsule(height: 2, color: Color(.systemGray3))
                    
                    
                    ZStack(alignment: .topLeading){
                        VStack(alignment: .leading, spacing: 30) {
                            
                            LocationInfo(location: array.publish.source, exactLocation: array.publish.source, time: DateTimeFormat.shared.timeFormat(date:  array.publish.time, is24hrs: false), walkDist: String(array.publish.distance ?? 0))
                                .padding(.bottom,90)
                            
                            LocationInfo(location: array.publish.destination, exactLocation: array.publish.destination, time: DateTimeFormat.shared.timeFormat(date:  array.reachTime, is24hrs: false), walkDist: String(array.publish.distance ?? 0))
                        }
                        .padding(.horizontal, 25)
                        PointToPointView(color: Color(.darkGray), height: 100)
                            .padding(.top, 10)
                        
                    }
                    .padding(.vertical)
                    .padding(.bottom,60)
                    
                    DividerCapsule(height: 2, color: Color(.systemGray3))
                    
                        VStack(alignment: .leading){
                            HStack{
                                Text(Constants.Description.bookedSeats)
                                    .font(.title3)
                                    .foregroundColor(Color(.darkGray))
                                Spacer()
                                Text("\(NumOfSeatSelected)")
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                            .padding(.top, -10)
                            
                            HStack{
                                Text(Constants.Description.totalPrice)
                                    .font(.title3)
                                    .foregroundColor(Color(.darkGray))
                                Spacer()
                                Text(String(format: Constants.StringFormat.oneDigit, array.publish.setPrice))
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
                        AsyncImage(url: array.imageURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    if array.imageURL == nil {
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
                            Text(array.name)
                                .foregroundColor(.black)
                                .font(.title3)
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
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.white)
                .cornerRadius(10)
                
            }
            DividerCapsule(height: 2, color: Color(.systemGray3))
            HStack{
                VStack(alignment: .leading){
                    
                    Text(Constants.Headings.paymentMethod)
                        .font(.title3)
                    Text(Constants.Description.toCompletePayment)
                        .foregroundColor(Color(.darkGray))
                        .font(.subheadline)
                    
                    Button {
                        carPoolVM.bookRideApiCall(method: .bookRide, httpMethod: .POST)
                    } label: {
                        ButtonView(buttonName: Constants.ButtonsTitle.confirmRide, border: false)
                            .background(Color(Color.redColor))
                            .cornerRadius(50)
                    }
                }
                
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationDestination(isPresented: $carPoolVM.bookApiSuccess, destination: {
            BookedRideView(carPoolVM: carPoolVM)
        })
        .onAppear{
            profileVM.vehicleId = String(array.publish.vehicleID)
            profileVM.getVehicleApiCall(method: .getVehicle, data: [:], httpMethod: .GET)
            carPoolVM.bookRideData.passenger.publishId = array.publish.id
            carPoolVM.bookRideData.passenger.seats = carPoolVM.numOfSeats
        }
    }
}

struct DetailsCard_Previews: PreviewProvider {
    static var previews: some View {
        DetailsCard(carPoolVM: CarPoolRidesViewModel(), isRideDetails: .constant(true), isSeatSelected: .constant(false), NumOfSeatSelected: .constant(1), array: .constant(DataArray(id: 0, name: "", reachTime: "", imageURL: nil, averageRating: nil, aboutRide: "", publish: PublishResponse(id: 0, source: "rtyj yj yjwy jw jtwy jwtrj j wry jwry trh", destination: "jetyetjetje jtytejye etjy eyj etjy tyj tyj ", passengersCount: 0, addCity: "", date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: "", midSeat: "", selectRoute: SelectRoute(), status: "", estimateTime: "", addCityLongitude: 0.0, addCityLatitude: 0.0, distance: nil, bearing: nil))))
            .environmentObject(SignInSignUpViewModel())
            .environmentObject(ProfileViewModel())
    }
}

struct LocationInfo: View {

        var location: String
        var exactLocation: String
        var time: String
        var walkDist: String
        

        var body: some View {
            GeometryReader{ _ in
                VStack(alignment: .leading, spacing: 4){
                    Text(location)
                        .foregroundColor(.black)
                        .font(.title2)
                    Text(exactLocation)
                    Text(time)
                    HStack{
                        Image(systemName: Constants.Images.walkingFig)
                            .foregroundColor(Color.green)
                        Text(walkDist + " km from location")
                            .font(.subheadline)
                            .foregroundColor(Color(.systemGray2))
                    }
                }
                .foregroundColor(Color(.darkGray))
            }
    }
}
