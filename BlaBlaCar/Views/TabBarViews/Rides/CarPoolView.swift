//
//  CarPoolView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct CarPoolView: View {
    
    @ObservedObject var mapVM: MapViewModel
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var navigationVM: NavigationViewModel
    
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack{
                Text(Constants.Headings.carPool)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
                    .padding()
                
                DividerCapsule(height: 4, color: Color(.systemGray3))
                HStack{
                    /// for each to show both book and offer ride options
                    ForEach(RideMethods.allCases, id: \.rawValue){ride in
                        VStack{
                            Text(ride.rawValue)
                                .font(.subheadline)
                                .fontWeight(carPoolVM.rideMethod == ride ? .semibold : .regular)
                                .foregroundColor(carPoolVM.rideMethod == ride ? .black : Color(.darkGray))
                            
                            /// to have a animated highlighter which
                            /// moves on tapping
                            if carPoolVM.rideMethod == ride {
                                DividerCapsule(height: 2, color: Color(Color.redColor))
                                    .matchedGeometryEffect(id: "filter", in: animation)
                            } else {
                                DividerCapsule(height: 2, color: .clear)
                            }
                        }
                        
                        /// to change the option with animation when tapped
                        .onTapGesture {
                            withAnimation(.easeIn){
                                carPoolVM.rideMethod = ride
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                /// scrollview that contains all the information other than the heading and sliding option selector
                ScrollView{
                    VStack{
                        ZStack(alignment: .leading){
                            VStack{
                                // textfields to get the location which changes
                                // based on the option selected from above
                                TextViewFields(text:  carPoolVM.rideMethod == .bookingRide ? carPoolVM.pickupLocation : carPoolVM.driverPickupLocation)
                                    .onTapGesture {
                                        carPoolVM.pickupLocationIsEmpty.toggle()
                                    }
                                    .padding(.vertical, 20)
                                
                                TextViewFields(text: carPoolVM.rideMethod == .bookingRide ? carPoolVM.dropLocation : carPoolVM.driverDropLocation)
                                    .onTapGesture {
                                        carPoolVM.dropLocationIsEmpty.toggle()
                                    }
                            }
                            /// Custom made view to make UI visually more appealing.
                            PointToPointView(color: Color(Color.redColor), height: 52)
                                .padding()
                                .padding(.top, 21)
                        }
                        .padding(.horizontal)
                        
                        /// to show date in different formats based on the option selected from above.
                        DateSelector(heading: carPoolVM.rideMethod == .bookingRide ? Constants.Headings.departureDate : Constants.Headings.departureDateAndTime, text: carPoolVM.departureDate.formatted(date: .long , time: carPoolVM.rideMethod == .bookingRide ? .omitted : .shortened))
                            .onTapGesture {
                                carPoolVM.toShowCalenderPicker.toggle()

                            }
                        /// sheet to show the date selector in different formats.
                            .sheet(isPresented: $carPoolVM.toShowCalenderPicker) {
                                DateCalenderView(date: $carPoolVM.departureDate, toShowCalenderPicker: $carPoolVM.toShowCalenderPicker, typeOfPicker: carPoolVM.rideMethod == .bookingRide ? .date : [.date, .hourAndMinute])
                                    .presentationDetents([.fraction(0.76)])
                            }
                        
                        if carPoolVM.rideMethod == .bookingRide {
                            NumOfSeatsView(text: String(carPoolVM.numOfSeats))
                                .onTapGesture {
                                    carPoolVM.isSeatSelected.toggle()
                                }
                        }
                        
                        /// to only have these options when publish a ride option is selected.
                        if carPoolVM.rideMethod != .bookingRide {
                            ForEach(0..<3){ selector in
                                
                                ParameterSelector(carPoolVM: carPoolVM, heading: carPoolVM.offerRideSelectorArray[selector].heading, text: carPoolVM.offerRideSelectorArray[selector].text)
                                    .onTapGesture {
                                        carPoolVM.offerRideSelectorArray[selector].isSelected.toggle()
                                    }
                                /// sheet to show different views based on the selection made using switch case.
                                    .sheet(isPresented: $carPoolVM.offerRideSelectorArray[selector].isSelected, content: {
                                        switch OfferRideSelector(rawValue: selector){
                                        case .SelectVehicle : SelectVehicleView(carPoolVM: carPoolVM, toShowSelectVehicle: $carPoolVM.offerRideSelectorArray[selector].isSelected)
                                                .presentationDetents([.fraction(0.76)])
                                        case .AvailableSeats : AvailableSeatsView(carPoolVM: carPoolVM, toShowAvailableSeats: $carPoolVM.offerRideSelectorArray[selector].isSelected)
                                                .presentationDetents([.fraction(0.76)])
                                        case .PricePerSeat : PricePerSeatView(carPoolVM: carPoolVM, toShowSeatPrice: $carPoolVM.offerRideSelectorArray[selector].isSelected)
                                                .presentationDetents([.fraction(0.76)])
                                        case .none : EmptyView()
                                        }
                                    })
                            }
                        }
                        
                        /// validations to have all fields filled during publishing of ride.
                        if carPoolVM.rideMethod == .offeringRide {
                            Text(Constants.Description.allFieldsMandatory)
                                .foregroundColor(Color(Color.redColor))
                                .font(.subheadline)
                                .padding(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    /// based on the option selected, button performs different functions.
                        Button {
                            if carPoolVM.rideMethod == .bookingRide {
                                carPoolVM.searchRideApiCall(method: .searchRide, httpMethod: .GET)
                            } else {
                                navigationVM.push(.carPoolPublish)
                                //carPoolVM.searchApiSuccess.toggle()
                            }
                        } label: {
                            ButtonView(buttonName: Constants.ButtonsTitle.search, border: false)
                                .background(carPoolVM.disableButton ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                                .cornerRadius(50)
                                .padding()
                        }
                        .disabled(carPoolVM.disableButton)
                        
                        
//                        if carPoolVM.rideMethod == .bookingRide {
//                            HorizontalRecentSearches()
//                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                
            }
        /// alert to show error whenever api call fails.
        .alert(Constants.ErrorBox.error, isPresented: $carPoolVM.hasError, actions: {
            Button(Constants.ErrorBox.okay, role: .cancel) {
                
            }
        }, message: {
            Text(carPoolVM.errorMessage1)
        })
        
        /// as soon as view appears date used for searching ride is updated so that we have a date for api call even if their are no changes made to date.
        .onAppear{
            if carPoolVM.rideMethod == .bookingRide {
                carPoolVM.rideSearchData.date = carPoolVM.departureDate.slashFormat(time: carPoolVM.departureDate.formatted(date: .numeric, time: .omitted))
            }
        }
        
        /// if button is not disabled for booking ride then api call for searching rides is made.
        .onChange(of: carPoolVM.disableButton, perform: { _ in
            if carPoolVM.rideMethod == .bookingRide && carPoolVM.disableButton{
                carPoolVM.searchRideApiCall(method: .searchRide, httpMethod: .GET)
            }
        })
        
        /// date for booking ride is getting updated regularly whenever any changes in date is happening.
        .onChange(of: carPoolVM.departureDate, perform: { _ in
            if carPoolVM.rideMethod == .bookingRide {
                carPoolVM.rideSearchData.date = carPoolVM.departureDate.slashFormat(time: carPoolVM.departureDate.formatted(date: .numeric, time: .omitted))
            }
        })
        
        /// as soon as view disappears all the parameters for publish ride must be updated so as successful api call for publishing ride can be made.
        .onDisappear{
            if carPoolVM.rideMethod == .offeringRide {
                carPoolVM.publishRideData.publish.date = carPoolVM.departureDate.formatted(date: .long, time: .omitted)
                carPoolVM.publishRideData.publish.time = carPoolVM.departureDate.formatted(date: .omitted, time: .shortened)
                
            }
            carPoolVM.publishRideData.publish.passengersCount = carPoolVM.offerRideSelectorArray[1].text
            carPoolVM.publishRideData.publish.setPrice = carPoolVM.offerRideSelectorArray[2].text
            
        }
        /// sheet to show seat selector view for publishing ride
        .sheet(isPresented: $carPoolVM.isSeatSelected) {
            SeatSelectorView(toShowSeatSelector: $carPoolVM.isSeatSelected, value: $carPoolVM.numOfSeats)
            .presentationDetents([.fraction(0.4)])
        }
        
        /// sheet to show location search view for pickup location
        .sheet(isPresented: $carPoolVM.pickupLocationIsEmpty, content: {
            LocationSearchView(carPoolVM: carPoolVM, mapVM: mapVM)
        })
        
        /// sheet to show location search view for drop location
        .sheet(isPresented: $carPoolVM.dropLocationIsEmpty, content: {
            LocationSearchView(carPoolVM: carPoolVM, mapVM: mapVM)
        })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
    }
}


struct CarPoolView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CarPoolView(mapVM: MapViewModel(), carPoolVM: CarPoolRidesViewModel())
            
        }
    }
}
