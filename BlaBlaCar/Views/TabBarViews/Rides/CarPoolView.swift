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
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    @Namespace var animation
    
    @State var height = 200
    
    var body: some View {
        VStack {
            VStack{
                Text(Constants.Headings.carPool)
                    .font(.system(size: 24, design: .rounded))
                    .bold()
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
                    .padding()
                
                DividerCapsule(height: 1, color: .gray.opacity(0.5))
                HStack{
                    /// for each to show both book and offer ride options
                    ForEach(RideMethods.allCases, id: \.rawValue){ride in
                        VStack{
                            Text(ride.rawValue)
                                .font(.system(size: 14, design: .rounded))
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
                                ZStack(alignment: .leading){
                                    TextViewFields(text: Constants.TextfieldPlaceholder.pickupLocation,
                                                   selectedText: carPoolVM.rideMethod == .bookingRide ? carPoolVM.pickupLocation : carPoolVM.driverPickupLocation,
                                                   horizontalSpace: .horizontal,
                                                   isEmpty: carPoolVM.rideMethod == .bookingRide ? carPoolVM.pickupLocation == Constants.TextfieldPlaceholder.pickupLocation : carPoolVM.driverPickupLocation == Constants.TextfieldPlaceholder.pickupLocation)
                                    .onTapGesture {
                                        carPoolVM.pickupLocationIsEmpty.toggle()
                                    }
                                    Image(systemName: Constants.Images.circleInsideCircle)
                                        .frame(width: 10, height: 10)
                                        .offset(x: 15)
                                        .foregroundColor(Color(Color.redColor))
                                    
                                    DottedLine()
                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                                        .frame(width: 1, height: 52)
                                        .offset(x: 19, y: 40)
                                        .foregroundColor(Color(Color.redColor))
                                }
                                .padding(.vertical, 20)
                                
                                
                                
                                ZStack(alignment: .leading){
                                    TextViewFields(text: Constants.TextfieldPlaceholder.dropLocation,
                                                   selectedText: carPoolVM.rideMethod == .bookingRide ? carPoolVM.dropLocation : carPoolVM.driverDropLocation,
                                                   horizontalSpace: .horizontal,
                                                   isEmpty: carPoolVM.rideMethod == .bookingRide ? carPoolVM.dropLocation == Constants.TextfieldPlaceholder.dropLocation : carPoolVM.driverDropLocation == Constants.TextfieldPlaceholder.dropLocation)
                                        .onTapGesture {
                                            carPoolVM.dropLocationIsEmpty.toggle()
                                        }
                                    Image(systemName: Constants.Images.circleInsideCircle)
                                        .frame(width: 10, height: 10)
                                        .offset(x: 15)
                                        .foregroundColor(Color(Color.redColor))
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        /// to show date in different formats based on the option selected from above.
                        DateSelector(heading: carPoolVM.rideMethod == .bookingRide ? Constants.Headings.departureDate : Constants.Headings.departureDateAndTime, text: carPoolVM.rideMethod == .bookingRide ? carPoolVM.departureDate.formatted(date: .long , time: .omitted) : carPoolVM.publishingDate.formatted(date: .long , time: .shortened))
                            .onTapGesture {
                                carPoolVM.toShowCalenderPicker.toggle()
                                
                            }
                        /// sheet to show the date selector in different formats.
                            .sheet(isPresented: $carPoolVM.toShowCalenderPicker) {
                                DateCalenderView(date: carPoolVM.rideMethod == .bookingRide ? $carPoolVM.departureDate : $carPoolVM.publishingDate, toShowCalenderPicker: $carPoolVM.toShowCalenderPicker, typeOfPicker: carPoolVM.rideMethod == .bookingRide ? .date : [.date, .hourAndMinute])
                            }
                        
                        if carPoolVM.rideMethod == .bookingRide {
                            NumOfSeatsView(text: carPoolVM.numOfSeats > 0 ? String(carPoolVM.numOfSeats) : "")
                                .onTapGesture {
                                    carPoolVM.isSeatSelected.toggle()
                                }
                        }
                        
                        /// to only have these options when publish a ride option is selected.
                        if carPoolVM.rideMethod != .bookingRide {
                            ForEach(0..<3){ selector in
                                
                                ParameterSelector(carPoolVM: carPoolVM, heading: carPoolVM.offerRideSelectorArray[selector].heading, text: carPoolVM.offerRideSelectorArray[selector].text, image: carPoolVM.offerRideSelectorArray[selector].image )
                                    .onTapGesture {
                                        carPoolVM.offerRideSelectorArray[selector].isSelected.toggle()
                                    }
                                /// sheet to show different views based on the selection made using switch case.
                                    .sheet(isPresented: $carPoolVM.offerRideSelectorArray[selector].isSelected, content: {
                                        switch OfferRideSelector(rawValue: selector){
                                        case .SelectVehicle : SelectVehicleView(carPoolVM: carPoolVM, toShowSelectVehicle: $carPoolVM.offerRideSelectorArray[selector].isSelected)
                                                .presentationDetents([.fraction(0.76)])
                                        case .AvailableSeats :
                                            SeatSelectorView(toShowSeatSelector: $carPoolVM.offerRideSelectorArray[selector].isSelected, value: $carPoolVM.numOfSeatsPublish)
                                            .presentationDetents([.fraction(0.4)])
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
                                .font(.system(size: 16, design: .rounded))
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
                            }
                        } label: {
                            ButtonView(buttonName: carPoolVM.rideMethod == .bookingRide ? Constants.ButtonsTitle.search : Constants.ButtonsTitle.next, border: false)
                                .background(carPoolVM.disableButton ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                                .cornerRadius(10)
                                .padding()
                        }
                        .disabled(carPoolVM.disableButton)
                        .frame(height: 50)
                    }
                }
            }
        
        /// as soon as view appears date used for searching ride is updated so that we have a date for api call even if their are no changes made to date.
        .onAppear{
            profileVM.vehicleListApiCall(method: .vehicleList, data: [:], httpMethod: .GET)
            if carPoolVM.rideMethod == .bookingRide {
                carPoolVM.rideSearchData.date = carPoolVM.departureDate.slashFormat(time: carPoolVM.departureDate.formatted(date: .numeric, time: .omitted))
            }
        }
        
        /// date for booking ride is getting updated regularly whenever any changes in date is happening.
        .onChange(of: carPoolVM.departureDate, perform: { _ in
            if carPoolVM.rideMethod == .bookingRide {
                carPoolVM.rideSearchData.date = carPoolVM.departureDate.slashFormat(time: carPoolVM.departureDate.formatted(date: .numeric, time: .omitted))
            }
        })
        /// as soon as view disappears all the parameters for publish ride must be updated so as successful api call for publishing ride can be made.
        .onDisappear{
            if carPoolVM.rideMethod == .offeringRide {
                carPoolVM.publishRideData.publish.date = carPoolVM.publishingDate.formatted(date: .long, time: .omitted)
                carPoolVM.publishRideData.publish.time = carPoolVM.publishingDate.formatted(date: .omitted, time: .shortened)
                
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
