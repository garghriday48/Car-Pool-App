//
//  AllRidesVIew.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct AllRidesView: View {
    
    @EnvironmentObject var vm: AuthViewModel
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        
        /// Placeholder view must be shown when their are no rides found on searching for a particular ride is done.
        if carPoolVM.rideSearchResponse.message == Constants.Description.noRidesFound {
            
            PlaceholderView(image: Constants.EmptyView.image,
                            title: Constants.EmptyView.title,
                            caption: Constants.EmptyView.caption,
                            needBackBtn: true)
        } else {
            
            /// to show the view consisting of all the rides that matches the searching parameters.
            VStack {
                HStack{
                    BackButton(image: Constants.Images.backArrow) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.title2)
                    VStack(alignment: .leading, spacing: 7){
                        HStack{
                            Text(carPoolVM.pickupLocation)
                            Image(systemName: Constants.Images.bigRightArrow)
                            Text(carPoolVM.dropLocation)
                        }
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.system(size: 18, design: .rounded))
                        Text(carPoolVM.rideMethod == .bookingRide ? carPoolVM.departureDate.formatted(date: .omitted, time: .shortened) : "")
                            .font(.system(size: 14, design: .rounded))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
                .background(Color(Color.redColor))
                
                
                /// horizontal scroll to show all the sorting parameters in less space.
                ScrollView(.horizontal){
                    HStack{
//                        Button {
//                            carPoolVM.filterAndSort.toggle()
//                        } label: {
//                            FilterBox(name: "Filter and sort", image: "slider.horizontal.3", isSelected: carPoolVM.filterAndSort)
//                        }
                        ForEach(0..<2){ filter in
                            Button {
                                carPoolVM.filtersArray[filter].isSelected.toggle()
                                carPoolVM.selectedPosition = filter
                                carPoolVM.rideSearchData.order = carPoolVM.filtersArray[filter].order
                                carPoolVM.searchRideApiCall(method: .searchRideByOrder, httpMethod: .GET)
                            } label: {
                                FilterBox(name: carPoolVM.filtersArray[filter].name, image: carPoolVM.filtersArray[filter].image, isSelected: carPoolVM.filtersArray[filter].isSelected)
                            }
                            
                            /// this is done so that an user can only apply one filter at any time.
                            .onChange(of: carPoolVM.selectedPosition) { newValue in
                                for num in 0..<carPoolVM.filtersArray.count {
                                    if num == newValue {
                                        
                                        continue
                                    } else {
                                        carPoolVM.filtersArray[num].isSelected = false
                                    }
                                }
                            }
                        }
                    }
                    
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal)
                
                /// Vertical scroll view to show all the rides searched.
                ScrollView{
                    VStack(alignment: .leading){
                        HStack{
                            Text("Showing \(carPoolVM.rideSearchResponse.data.count)")
                            Text(carPoolVM.rideSearchResponse.data.count == 1 ? Constants.Description.ride : Constants.Description.rides)
                        }
                        .font(.system(size: 14, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color(.darkGray))
                        .padding(.bottom)
                        
                        ForEach($carPoolVM.rideSearchResponse.data, id: \.self){ $name in
                            
                            /// navigation link to see details of ride selected.
                            Button {
                                carPoolVM.toShowSearchDetails.toggle()
                                
                            } label: {
                                RideCard(carPoolVM: carPoolVM, array: $name)
                            }
                            .navigationDestination(isPresented: $carPoolVM.toShowSearchDetails, destination: {
                                RideDetailsView(carPoolVM: carPoolVM, array: $name)
                            })
                        }
                    }
                    .padding()
                }
            }
            
            /// api call to get all the rides based on parameters used for searching of a ride.
            .onAppear{
                vm.userId = vm.userData?.status.data?.id ?? 0
                vm.getProfileApiCall(method: .getDetails, httpMethod: .GET, data: [:])
            }
            
            /// to present filter view so as to filter rides result based on filter selected
            .sheet(isPresented: $carPoolVM.filterAndSort, content: {
                FilterAndSortView(carPoolVM: carPoolVM, toShowSelectVehicle: $carPoolVM.filterAndSort)
            })
            
            .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct AllRidesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AllRidesView(carPoolVM: CarPoolRidesViewModel())
                .environmentObject(AuthViewModel())
        }
    }
}
