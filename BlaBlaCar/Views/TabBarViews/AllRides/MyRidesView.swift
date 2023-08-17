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
    
    @State var searchBookedLocation = ""
    @State var searchPublishedLocation = ""
        
    
    var body: some View {
        VStack{
            Text(Constants.Headings.myRides)
                .font(.system(size: 24, design: .rounded))
                .bold()
                .frame(maxWidth: .infinity ,alignment: .topLeading)
                .padding()
            
            DividerCapsule(height: 1, color: .gray.opacity(0.5))
            
            NavigationView{
                VStack{
                    HStack{
                        ForEach(RideType.allCases, id: \.rawValue){ride in
                            VStack{
                                Text(ride.rawValue)
                                    .font(.system(size: 14, design: .rounded))
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
                                //                                withAnimation(.easeIn){
                                //                                    myRidesVM.rideType = ride
                                //                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    if myRidesVM.rideType == .booked {
                        if myRidesVM.bookingListResponse.rides[0].ride.id == 0 {
                            
                            /// Placeholder view must be shown when their are no rides found on searching for a particular ride is done.
                            PlaceholderView(image: Constants.EmptyView.myRideImage,
                                            title: Constants.EmptyView.noBookedRides,
                                            caption: Constants.EmptyView.caption,
                                            needBackBtn: false, height: 150, width: 200)
                        } else {
                            List{
                                ForEach(searchBookedResults.reversed(), id: \.bookingID){rides in
                                    if rides.ride.id != 0{
                                        RidesBookedCard(array: rides)
                                            .listRowSeparator(.hidden)
                                            .background(
                                                NavigationLink {
                                                    BookedRideDetails(carPoolVM: carpoolVM, array: rides)
                                                } label: {
                                                    EmptyView()
                                                }
                                            )
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .scrollIndicators(.hidden)
                            .searchable(text: $searchBookedLocation)
                            .refreshable {
                                myRidesVM.bookingRideApiCall(method: .bookingList, httpMethod: .GET)
                            }
                        }
                    }
                    
                    
                    
                    if myRidesVM.rideType == .published {
                        if myRidesVM.publishListResponse.data[0].id == 0{
                            
                            /// Placeholder view must be shown when their are no rides found on searching for a particular ride is done.
                            PlaceholderView(image: Constants.EmptyView.myRideImage,
                                            title: Constants.EmptyView.noPublishedRides,
                                            caption: Constants.EmptyView.caption,
                                            needBackBtn: false, height: 150, width: 200)
                        } else {
                            List{
                                ForEach(searchPublishedResults.reversed(), id: \.id){data in
                                    if data.id != 0{
                                        Button {
                                            myRidesVM.publishId = data.id
                                            myRidesVM.publishWithIdApiCall(method: .publishById, httpMethod: .GET)
                                        } label: {
                                            RidesPublishedCard(array: data)
                                            
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .scrollIndicators(.hidden)
                            .searchable(text: $searchPublishedLocation)
                            .refreshable {
                                myRidesVM.publishRideApiCall(method: .publishList, httpMethod: .GET)
                            }
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $myRidesVM.navigateToPublishDetails, destination: {
            PublishedRideDetails()
        })
        .alert(myRidesVM.rideType == .booked ? Constants.ErrorBox.cancelRide : Constants.ErrorBox.cancelPublishedRide , isPresented: $myRidesVM.cancelBooking, actions: {
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
        .onChange(of: searchBookedLocation) { _ in
            searchPublishedLocation = ""
        }
        .onChange(of: searchPublishedLocation) { _ in
            searchBookedLocation = ""
        }
    }
    
    ///Show the entire list if search field is blank else show compatible items
    var searchBookedResults: [RideElement] {
        if searchBookedLocation.isEmpty {
            return myRidesVM.bookingListResponse.rides
        } else {
            return myRidesVM.bookingListResponse.rides.filter { $0.ride.source.lowercased().contains(searchBookedLocation.lowercased()) || $0.ride.destination.lowercased().contains(searchBookedLocation.lowercased())}
        }
    }
    
    ///Show the entire list if search field is blank else show compatible items
    var searchPublishedResults: [GetPublishResponse] {
        if searchPublishedLocation.isEmpty {
            return myRidesVM.publishListResponse.data
        } else {
            return myRidesVM.publishListResponse.data.filter {
                $0.source.lowercased().contains(searchPublishedLocation.lowercased()) || $0.destination.lowercased().contains(searchPublishedLocation.lowercased())}
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
