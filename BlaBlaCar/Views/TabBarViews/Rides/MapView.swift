//
//  MapView.swift
//  BlaBlaCar
//
//  Created by Pragath on 24/05/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var mapVM: MapViewModel
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    var body: some View {
            VStack{
                Capsule()
                    .frame(width: 40, height: 4)
                    .foregroundColor(Color(.systemGray3))
                    .padding(.top)
                HStack{
                    ZStack{
                        Button {
                            mapVM.toShowMap.toggle()
                        } label: {
                            Text(Constants.ButtonsTitle.close)
                                .font(.headline)
                                .foregroundColor(Color(.systemGray))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                        Text(Constants.Headings.selectLocation)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                }
                
                    /// to show map
                    MapViewHelper(mapVM: mapVM)
                        .ignoresSafeArea()
                    
                
                
                /// to show the name and sub name of location selected.
                if let place = mapVM.pickedPlacemark {
                    if let name = Placemark(item: place){
                        VStack{
                            Text(Constants.Headings.confirmLocation)
                                .font(.title2.bold())
                            
                            LocationCell(name: name.location, secondayName: name.subLocation)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                            
                            /// searched location is assigned to a variable based on the method selected which is checked using switch case.
                            /// This location is used for both searching and publishing of rides based on the method which was selected,
                            Button {
                                if carPoolVM.pickupLocationIsEmpty {
                                    switch carPoolVM.rideMethod {
                                    case .bookingRide:
                                        carPoolVM.offerSourceCoordinate = place.location?.coordinate ?? CLLocationCoordinate2D()
                                        carPoolVM.pickupLocation = name.subLocation
                                        carPoolVM.pickupLocationIsEmpty.toggle()
                                    case .offeringRide:
                                        carPoolVM.publishRideData.publish.source = name.subLocation
                                        carPoolVM.sourceCoordinate = place.location?.coordinate ?? CLLocationCoordinate2D()
                                        
                                        carPoolVM.driverPickupLocation = name.subLocation
                                        carPoolVM.pickupLocationIsEmpty.toggle()
                                    }
                                    
                                } else if carPoolVM.dropLocationIsEmpty {
                                    switch carPoolVM.rideMethod {
                                    case .bookingRide:
                                        carPoolVM.offerDestinationCoordinate = place.location?.coordinate ?? CLLocationCoordinate2D()
                                        carPoolVM.dropLocation = name.subLocation
                                        carPoolVM.dropLocationIsEmpty.toggle()
                                    case .offeringRide:
                                        carPoolVM.publishRideData.publish.destination = name.subLocation
                                        carPoolVM.destinationCoordinate = place.location?.coordinate ?? CLLocationCoordinate2D()
                                        
                                        carPoolVM.driverDropLocation = name.subLocation
                                        carPoolVM.dropLocationIsEmpty.toggle()
                                    }
                                }
                                mapVM.toShowMap = false
                                
                            } label: {
                                ButtonView(buttonName: Constants.ButtonsTitle.proceed, border: false)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(Color.redColor)))
                            }
                            
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                        )
                        .frame(alignment: .bottom)
                    }
                }
            }
            
            /// pin to show location is reset to original value so that location showed at the time is only of the current searched location.
            .onDisappear{
                carPoolVM.toSetCoordinates()
                mapVM.pickedLocation = nil
                mapVM.pickedPlacemark = nil
                
                mapVM.mapView.removeAnnotations(mapVM.mapView.annotations)
                mapVM.mapView.removeOverlays(mapVM.mapView.overlays)
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapVM: MapViewModel(), carPoolVM: CarPoolRidesViewModel())
    }
}
