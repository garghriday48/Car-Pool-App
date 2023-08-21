//
//  PublishedRideDetails.swift
//  BlaBlaCar
//
//  Created by Pragath on 14/06/23.
//

import SwiftUI

struct PublishedRideDetails: View {
    @Environment (\.presentationMode) var presentationMode
    
    @EnvironmentObject var vm: AuthViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @EnvironmentObject var carPoolVM: CarPoolRidesViewModel

    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                BackButton(image: Constants.Images.backArrow) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.system(size: 20, weight: .semibold ,design: .rounded))
                .bold()
                Text(Constants.Headings.ridePlan)
                    .foregroundColor(.black)
                    .font(.system(size: 22, weight: .semibold ,design: .rounded))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            ScrollView{
                VStack(alignment: .leading){
                    Text(Constants.Headings.tripInfo)
                        .foregroundColor(.black)
                        .font(.system(size: 22, weight: .semibold ,design: .rounded))
                        .padding(.bottom)
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            Image(systemName: Constants.Images.calendar)
                            Text(DateTimeFormat.shared.dateFormat(date: myRidesVM.publishResponseWithId.data.date))
                        }
                        .foregroundColor(Color(.darkGray))
                        
                        HStack{
                            Image(systemName: Constants.Images.clock)
                            if let estimatedTime = myRidesVM.publishResponseWithId.data.estimateTime {
                                Text(DateTimeFormat.shared.timeFormat(date: estimatedTime, is24hrs: true, toNotReduce: false) + " hrs")
                            }
                        }
                        .foregroundColor(Color(.darkGray))
                    }
                    .font(.system(size: 16, weight: .semibold ,design: .rounded))
                    .padding(.vertical)
                    
                    DividerCapsule(height: 2, color: Color(.systemGray3))
                    
                    
                    ZStack(alignment: .topLeading){
                        VStack(alignment: .leading, spacing: 30) {
                            
                            LocationInfo(location: myRidesVM.publishResponseWithId.data.source, exactLocation: myRidesVM.publishResponseWithId.data.source, time: DateTimeFormat.shared.timeFormat(date:  myRidesVM.publishResponseWithId.data.time ?? "", is24hrs: false, toNotReduce: false), walkDist: "0.0")
                                .padding(.bottom, 100)
                            
                            LocationInfo(location: myRidesVM.publishResponseWithId.data.destination, exactLocation: myRidesVM.publishResponseWithId.data.destination, time: DateTimeFormat.shared.timeFormat(date:  myRidesVM.publishResponseWithId.reachTime ?? "", is24hrs: false, toNotReduce: false), walkDist: "0.0")
                        }
                        .padding(.horizontal, 25)
                        PointToPointView(color: Color(.darkGray), height: 103)
                            .padding(.top, 10)
                        
                    }
                    .padding(.vertical)
                    .padding(.bottom, 70)
                    
                    DividerCapsule(height: 1, color: .gray.opacity(0.3))
                    
                        VStack(alignment: .leading){
                            
                            HStack{
                                Text(Constants.Description.priceOneSeat)
                                    .font(.system(size: 18, weight: .semibold ,design: .rounded))
                                    .foregroundColor(Color(.darkGray))
                                Spacer()
                                Text("Rs \(String(format: Constants.StringFormat.zeroDigit, myRidesVM.publishResponseWithId.data.setPrice))")
                                    .font(.system(size: 20, weight: .semibold ,design: .rounded))
                                    .foregroundColor(.black)
                            }
                            .padding(.top, -10)
                            
                            Text(Constants.Description.paymentType)
                                .font(.subheadline)
                                .foregroundColor(Color(.systemGray2))
                            
                        }
                        .padding(.vertical, 30)
                        
                    DividerCapsule(height: 1, color: .gray.opacity(0.3))
                    
                    
//                       
                    VStack(alignment: .leading) {
                        Text(Constants.Headings.vehicleDetails).font(.system(size: 18, weight: .semibold ,design: .rounded))
                            .padding(.bottom)
                        Text(profileVM.getVehicleData.vehicleBrand).font(.system(size: 16 ,design: .rounded)) +
                        Text(" ") +
                        Text(profileVM.getVehicleData.vehicleName)
                            .font(.system(size: 16 ,design: .rounded)) +
                        Text(Constants.Description.dash + profileVM.getVehicleData.vehicleType).font(.system(size: 16 ,design: .rounded))
                        
                        Text(Constants.Description.number + profileVM.getVehicleData.vehicleNumber)
                            .font(.system(size: 14 ,design: .rounded))
                        Text(Constants.Description.color + profileVM.getVehicleData.vehicleColor).font(.system(size: 14 ,design: .rounded))
                        DividerCapsule(height: 1, color: .gray.opacity(0.3))
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading){
//                        if myRidesVM.publishResponseWithId.passengers?.count != 0 {
                            Text(Constants.Headings.passengers).font(.title2).fontWeight(.semibold)
                        if myRidesVM.publishResponseWithId.passengers?.count != 0 {
                            ForEach(myRidesVM.publishResponseWithId.passengers ?? [], id:\.userID){ data in
                                NavigationLink {
                                    PassengerDetailsCard(array: data)
                                } label: {
                                    PassengersCard(array: data)
                                }
                            }
                        } else {
                            Text("Currently there are no bookings.")
                                .foregroundColor(Color(Color.redColor))
                                .font(.system(size: 14, weight: .semibold ,design: .rounded))
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                        }
                    }
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading){
                        
                        if myRidesVM.publishResponseWithId.data.status == RidePublishedType.pending.rawValue {
                            
                            Button {
                                myRidesVM.toDismissEditView.toggle()
                                
                            } label: {
                                ButtonView(buttonName: Constants.Headings.editYourPublication, border: true, color: .blue)
//                                Text(Constants.Headings.editYourPublication).bold().padding(.top)
//                                    .font(.title3)
                            }
                            Button {
                                myRidesVM.cancelRideData.id = myRidesVM.publishResponseWithId.data.id
                                myRidesVM.cancelBooking.toggle()
                            } label: {
                                ButtonView(buttonName: Constants.Headings.cancelYOurRide, border: true)
//                                Text(Constants.Headings.cancelYOurRide).bold().padding(.top)
//                                    .font(.title3).foregroundColor(Color(Color.redColor))
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.white)
                .cornerRadius(10)
            }
        }
        .fullScreenCover(isPresented: $myRidesVM.toDismissEditView, content: {
            EditPublishedRideView()
        })
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)

        .onAppear{
            
            profileVM.vehicleId = String(myRidesVM.publishResponseWithId.data.vehicleID ?? 0)
            profileVM.getVehicleApiCall(method: .getVehicle, data: [:], httpMethod: .GET)
            myRidesVM.time = DateTimeFormat.shared.timeFormat(date:  myRidesVM.publishResponseWithId.data.time ?? "", is24hrs: false, toNotReduce: false)
        }
        .onChange(of: myRidesVM.isRideCancelled) { _ in
            if myRidesVM.isRideCancelled {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .onDisappear{
            myRidesVM.publishWithIdSuccess = false
        }
        
    }
}

struct PublishedRideDetails_Previews: PreviewProvider {
    static var previews: some View {
        PublishedRideDetails()
            .environmentObject(CarPoolRidesViewModel())
            .environmentObject(AuthViewModel())
            .environmentObject(ProfileViewModel())
            .environmentObject(MyRidesViewModel())
    }
}
