//
//  MyRidesView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct MyRidesView: View {
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @EnvironmentObject var carpoolVM: CarPoolRidesViewModel
    @EnvironmentObject var vm: SignInSignUpViewModel
    
    
    var body: some View {
        VStack{
            Text(Constants.Headings.myRides)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity ,alignment: .topLeading)
                .padding()
            
            DividerCapsule(height: 4, color: Color(.systemGray3))
            HStack{
                ForEach(RideType.allCases, id: \.rawValue){ride in
                    VStack{
                        Text(ride.rawValue)
                            .font(.subheadline)
                            .fontWeight(myRidesVM.rideType == ride ? .semibold : .regular)
                            .foregroundColor(myRidesVM.rideType == ride ? .black : Color(.darkGray))
                        
                        if myRidesVM.rideType == ride {
                            DividerCapsule(height: 2, color: Color(Color.redColor))
                        } else {
                            DividerCapsule(height: 2, color: .clear)
                        }
                    }
                    .onTapGesture {
                        myRidesVM.rideType = ride
                        withAnimation(.linear){
                            myRidesVM.rideType = ride
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            List{
                if myRidesVM.rideType == .booked {
                    ForEach(myRidesVM.bookingListResponse.rides, id: \.bookingID){rides in
                        RidesBookedCard(array: rides)
                            .background(
                                NavigationLink {
                                    BookedRideDetails(carPoolVM: carpoolVM, array: rides)
                                } label: {
                                    EmptyView()
                                }
                            )
                    }
                }
                
                if myRidesVM.rideType == .published {
                    ForEach(myRidesVM.publishListResponse.data, id: \.id){data in
                        Button {
                            myRidesVM.publishId = data.id
                            myRidesVM.publishWithIdApiCall(method: .publishById, httpMethod: .GET)
                        } label: {
                            RidesPublishedCard(array: data)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            
            .refreshable {
                switch myRidesVM.rideType {
                case .published: myRidesVM.publishRideApiCall(method: .publishList, httpMethod: .GET)
                case .booked : myRidesVM.bookingRideApiCall(method: .bookingList, httpMethod: .GET)
                }
            }
        }
        .navigationDestination(isPresented: $myRidesVM.navigateToPublishDetails, destination: {
            PublishedRideDetails()
        })
        .alert("Are you sure you want to cancel Ride booking?", isPresented: $myRidesVM.cancelBooking, actions: {
            Button(Constants.ButtonsTitle.yes, role: .destructive) {
                switch myRidesVM.rideType {
                case .booked: myRidesVM.cancelRideApiCall(method: .cancelRide, httpMethod: .POST)
                case .published: myRidesVM.cancelRideApiCall(method: .cancelPublishedRide, httpMethod: .POST)
                }
                
            }
        })
        /// alert to show error whenever api call fails.
        .alert(Constants.ErrorBox.error, isPresented: $myRidesVM.hasError, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) {}
        }, message: {
            Text(myRidesVM.errorMessage1)
        })
        .onAppear{
            myRidesVM.publishRideApiCall(method: .publishList, httpMethod: .GET)
            myRidesVM.bookingRideApiCall(method: .bookingList, httpMethod: .GET)
        }
        .onChange(of: myRidesVM.publishWithIdSuccess) { _ in
            if myRidesVM.publishWithIdSuccess {
                myRidesVM.navigateToPublishDetails.toggle()
            }
        }
    }
}

struct MyRidesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRidesView()
            .environmentObject(MyRidesViewModel())
            .environmentObject(SignInSignUpViewModel())
    }
}
