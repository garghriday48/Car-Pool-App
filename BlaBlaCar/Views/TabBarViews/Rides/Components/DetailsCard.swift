//
//  DetailsCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct DetailsCard: View {
    
    @EnvironmentObject var vm: AuthViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
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
                        .font(.system(size: 20, weight: .bold, design: .rounded))
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
                                Text(DateTimeFormat.shared.timeFormat(date: estimatedTime, is24hrs: true, toNotReduce: false) + " hrs")
                            }
                        }
                        .foregroundColor(Color(.darkGray))
                    }
                    .font(.system(size: 16, weight: .semibold ,design: .rounded))
                    .padding(.vertical)
                    
                    DividerCapsule(height: 1, color: .gray.opacity(0.3))
                    
                    
                    ZStack(alignment: .topLeading){
                        VStack(alignment: .leading, spacing: 30) {
                            
                            LocationInfo(location: array.publish.source, exactLocation: array.publish.source, time: DateTimeFormat.shared.timeFormat(date:  array.publish.time, is24hrs: false, toNotReduce: false), walkDist: String(array.publish.distance ?? 0))
                                .padding(.bottom,90)
                            
                            LocationInfo(location: array.publish.destination, exactLocation: array.publish.destination, time: DateTimeFormat.shared.timeFormat(date:  array.reachTime, is24hrs: false, toNotReduce: false), walkDist: String(array.publish.distance ?? 0))
                        }
                        .padding(.horizontal, 25)
                        PointToPointView(color: Color(.darkGray), height: 95)
                            .padding(.top, 10)
                        
                    }
                    .padding(.vertical)
                    .padding(.bottom,60)
                    
                    DividerCapsule(height: 1, color: .gray.opacity(0.3))
                    
                        VStack(alignment: .leading){
                            HStack{
                                Text(Constants.Description.bookedSeats)
                                    .font(.system(size: 18, weight: .semibold ,design: .rounded))
                                    .foregroundColor(Color(.darkGray))
                                Spacer()
                                Text("\(NumOfSeatSelected)")
                                    .font(.system(size: 20 ,design: .rounded))
                                    .foregroundColor(.black)
                            }
                            .padding(.top, -10)
                            
                            HStack{
                                Text(Constants.Description.totalPrice)
                                    .font(.system(size: 18, weight: .semibold ,design: .rounded))
                                    .foregroundColor(Color(.darkGray))
                                Spacer()
                                Text(String(format: Constants.StringFormat.oneDigit, array.publish.setPrice))
                                    .font(.system(size: 20 ,design: .rounded))
                                    .foregroundColor(.black)
                            }
                            .padding(.top, -10)
                            
                            Text(Constants.Description.paymentType)
                                .font(.system(size: 14, weight: .semibold ,design: .rounded))
                                .foregroundColor(Color(.systemGray2))
                            
                        }
                        .padding(.vertical)
                        
                    DividerCapsule(height: 1, color: .gray.opacity(0.3))
                    
                    
                    HStack {
                        ImageView(size: 60,
                                  imageName: array.imageURL,
                                  condition: array.imageURL == nil)
//                        AsyncImage(url: array.imageURL) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
//                                } placeholder: {
//                                    if array.imageURL == nil {
//                                        Image(Constants.Images.person)
//                                            .resizable()
//                                            .scaledToFill()
//                                    } else {
//                                        ZStack {
//                                            Color.gray.opacity(0.1)
//                                            ProgressView()
//                                        }
//                                    }
//                                }
//                            .frame(width: 60, height: 60)
//                            .clipShape(Circle())
//                            .overlay {
//                                Circle().stroke(lineWidth: 1)
//                            }
                        VStack(alignment: .leading, spacing: 4){
                            Text(array.name)
                                .foregroundColor(.black)
                                .font(.system(size: 20 ,design: .rounded))
                            HStack{
                                Text("4.5")
                                Image(systemName: Constants.Images.starFilled)
                                Circle()
                                    .frame(width: 5, height: 5)
                                Text("27 Ratings")
                            }
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(Color(.darkGray))
                        }
                    }
                    .padding(.vertical)
                    VStack(alignment: .leading) {
                        Text(Constants.Headings.vehicleDetails).font(.system(size: 18, weight: .semibold ,design: .rounded))
                            .padding(.bottom)
                        
                        Text(profileVM.getVehicleData.vehicleBrand).font(.system(size: 16 ,design: .rounded)) +
                        Text(" ") +
                        Text(profileVM.getVehicleData.vehicleName)
                            .font(.system(size: 16 ,design: .rounded)) +
                        Text(Constants.Description.dash + profileVM.getVehicleData.vehicleType)
                        
                        Text(Constants.Description.number + profileVM.getVehicleData.vehicleNumber)
                            .font(.system(size: 14 ,design: .rounded))
                        Text(Constants.Description.color + profileVM.getVehicleData.vehicleColor).font(.system(size: 14 ,design: .rounded))
                        DividerCapsule(height: 2, color: Color(.systemGray3))
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.white)
                .cornerRadius(10)
                
            }
            DividerCapsule(height: 1, color: .gray.opacity(0.5))
            HStack{
                VStack(alignment: .leading){
                    
                    Text(Constants.Headings.paymentMethod)
                        .font(.system(size: 18, weight: .semibold ,design: .rounded))
                    Text(Constants.Description.toCompletePayment)
                        .foregroundColor(Color(.darkGray))
                        .font(.system(size: 14 ,design: .rounded))
                    
                    Button {
                        if vm.userResponse.status.data?.phone_number == "" {
                            carPoolVM.noPhoneFound = true
                        } else if !(vm.profileResponse.user?.phone_verified ?? false) {
                            carPoolVM.isPhoneVerified = true
                        } else {
                            carPoolVM.bookRideApiCall(method: .bookRide, httpMethod: .POST)
                        }
                    } label: {
                        ButtonView(buttonName: Constants.ButtonsTitle.confirmRide, border: false)
                            .background(Color(Color.redColor))
                            .cornerRadius(10)
                    }
                }
                
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationDestination(isPresented: $carPoolVM.bookApiSuccess, destination: {
            CompletedView(carPoolVM: carPoolVM, heading: Constants.Headings.rideBooked)
        })
        .onAppear{
            profileVM.vehicleId = String(array.publish.vehicleID)
            profileVM.getVehicleApiCall(method: .getVehicle, data: [:], httpMethod: .GET)
            carPoolVM.bookRideData.passenger.publishId = array.publish.id
            carPoolVM.bookRideData.passenger.seats = carPoolVM.numOfSeats
        }
        .navigationDestination(isPresented: $vm.goToEditProfileView, destination: {
            EditProfileView(vm: vm, profileVM: profileVM)
        })
        .fullScreenCover(isPresented: $vm.toDisplayPhoneVerification ){
            PhoneVerificationView(profileVM: profileVM)
        }
        .alert(Constants.ErrorBox.confirmPhone, isPresented: $carPoolVM.isPhoneVerified, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) { vm.toDisplayPhoneVerification = true }
        }, message: { Text(Constants.ErrorBox.confirmPhnMsg) })
        
        .alert(Constants.ErrorBox.addPhone, isPresented: $carPoolVM.noPhoneFound, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) { vm.goToEditProfileView = true }
        }, message: { Text(Constants.ErrorBox.addPhnMsg) })
        
        .alert(Constants.ErrorBox.error, isPresented: $errorVM.hasResponseError, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) {
                
            }
        }, message: {
            Text(errorVM.errorMessage1)
        })
        
    }
}

struct DetailsCard_Previews: PreviewProvider {
    static var previews: some View {
        DetailsCard(carPoolVM: CarPoolRidesViewModel(), isRideDetails: .constant(true), isSeatSelected: .constant(false), NumOfSeatSelected: .constant(1), array: .constant(DataArray(id: 0, name: "", reachTime: "", imageURL: nil, averageRating: nil, aboutRide: "", publish: PublishResponse(id: 0, source: "rtyj yj yjwy jw jtwy jwtrj j wry jwry trh", destination: "jetyetjetje jtytejye etjy eyj etjy tyj tyj ", passengersCount: 0, addCity: "", date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: "", midSeat: "", selectRoute: SelectRoute(), status: "", estimateTime: "", addCityLongitude: 0.0, addCityLatitude: 0.0, distance: nil, bearing: nil))))
            .environmentObject(AuthViewModel())
            .environmentObject(ProfileViewModel())
            .environmentObject(ResponseErrorViewModel.shared)
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
                        .font(.system(size: 18, weight: .semibold ,design: .rounded))
                    Group{
                        Text(exactLocation)
                        Text(time)
                    }
                    .font(.system(size: 16, design: .rounded))
                    HStack{
                        Image(systemName: Constants.Images.walkingFig)
                            .foregroundColor(Color.green)
                        Text(String(format: Constants.StringFormat.twoDigit, walkDist) + " km from location")
                            .foregroundColor(Color(.systemGray2))
                    }
                    .font(.system(size: 14, weight: .semibold ,design: .rounded))
                }
                .foregroundColor(Color(.darkGray))
            }
    }
}
