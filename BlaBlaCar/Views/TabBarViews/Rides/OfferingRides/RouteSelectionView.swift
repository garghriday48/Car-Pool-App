//
//  RouteSelectionView.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI
import MapKit

struct RouteSelectionView: View {
    
    @ObservedObject var mapVM: MapViewModel
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    @ObservedObject var myRidesVM: MyRidesViewModel
    @Environment (\.presentationMode) var presentationMode
    
   // let map: MKMapView?
    
    var body: some View {
        VStack{
            HStack{
                BackButton(image: Constants.Images.backArrow) {
                    presentationMode.wrappedValue.dismiss()
                    mapVM.mapView.removeAnnotations(mapVM.mapView.annotations)
                    mapVM.mapView.removeOverlays(mapVM.mapView.overlays)
                }
                .font(.title)
                Text(Constants.Headings.routeSelection)
                    .font(.system(size: 18 ,design: .rounded))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            
            /// to show map with polyline that connects source and destination when the ride is being published.
            MapRoute(sourceCoordinate: carPoolVM.sourceCoordinate,
                     destinationCoordinate: carPoolVM.destinationCoordinate,
                     mapVM: mapVM,
                     carPoolVM: carPoolVM)
            .onTapGesture(perform: {location in
                
                // to get coordinate where the person touches the screen
                let coordinate = mapVM.mapView.convert(location, toCoordinateFrom: nil)
                
                //to convert the coordinates of touched point to 2-D coordinates according to map lat-long.
                let mappoint = MKMapPoint(coordinate)
                
                for route in (mapVM.mapRoutes ?? []){
                    
                     let polyline = route.polyline
                        
                    guard let renderer = mapVM.mapView.renderer(for: polyline) as? MKPolylineRenderer else { continue }
                    let tapPoint = renderer.point(for: mappoint)
                    
                    // Checks if the required touch point is in the rendered area of that polyline
                    if renderer.path.contains(tapPoint) {
                        mapVM.isFirstRoute = true
                        print("Tap was inside this polyline")
                        myRidesVM.totalDistance = route
                        carPoolVM.totalDistance = route
                        //
                        myRidesVM.estimatedTime = route.expectedTravelTime
                        carPoolVM.estimatedTime = route.expectedTravelTime
                        //break // If you have overlapping overlays then you'll need an array of overlays which the touch is in, so remove this line.
                    }
                    
                    continue
                    
                }
            })

            
            Spacer()
            VStack{
                HStack{
                    Text(Constants.Headings.totalDistanceInKm)
                    Spacer()
                    /// text to show distance from source to destination in km.
                    Text(carPoolVM.getValue(value: (carPoolVM.totalDistance.distance)/1000, format: Constants.StringFormat.twoDigit) + Constants.Description.kilometer)
                    
                }
                .font(.system(size: 18, weight: .semibold ,design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                HStack{
                    Text(Constants.Headings.estimatedTime)
                    Spacer()
                    /// to show estimated time to reach destination and conditions to check whether to show time in mins or hrs.
                    if carPoolVM.estimatedTime < 3600 {
                        Text(String(format: Constants.StringFormat.zeroDigit, carPoolVM.estimatedTime/60) + Constants.Description.minute)
                    } else if carPoolVM.estimatedTime >= 3600 {
                        Text(String(format: Constants.StringFormat.twoDigit, carPoolVM.estimatedTime/3600) + Constants.Description.hour)
                    }
                }
                .font(.system(size: 18, weight: .semibold ,design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Button {
                    carPoolVM.navigateToMapRoute.toggle()
                } label: {
                    ButtonView(buttonName: Constants.ButtonsTitle.proceed, border: true)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $carPoolVM.navigateToMapRoute, destination: {
            AdditionalInfoView(mapVM: mapVM, carPoolVM: carPoolVM)
        })
        
        /// to assign the estimate time value to another variable which is used when publishing ride so that user that is booking ride can seen the time that will be taken to reach destination.
        .onDisappear{
            carPoolVM.publishRideData.publish.estimateTime = DateTimeFormat.shared.toConvertDate(seconds: Int(carPoolVM.estimatedTime))
        }
    }
}

struct RouteSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RouteSelectionView(mapVM: MapViewModel(), carPoolVM: CarPoolRidesViewModel(), myRidesVM: MyRidesViewModel())
    }
}
