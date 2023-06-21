//
//  EditRouteView.swift
//  BlaBlaCar
//
//  Created by Pragath on 16/06/23.
//

import SwiftUI

struct EditRouteView: View {
    
    @EnvironmentObject var mapVM: MapViewModel
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @EnvironmentObject var carPoolVM: CarPoolRidesViewModel
    
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            HStack{
                BackButton(image: Constants.Images.backArrow) {
                    dismiss()
                }
                .font(.title)
                .bold()
                Text(Constants.Headings.routeSelection)
                    .font(.title2)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            
            /// to show map with polyline that connects source and destination when the ride is being published.
            MapRoute(sourceCoordinate: myRidesVM.editSourceCoordinate,
                     destinationCoordinate: myRidesVM.editDestCoordinate,
                     mapVM: mapVM,
                     carPoolVM: carPoolVM)

            
            Spacer()
            VStack{
                HStack{
                    Text(Constants.Headings.totalDistanceInKm)
                        
                    Spacer()
                    
                    /// text to show distance from source to destination in km.
                    Text(String(format: Constants.StringFormat.twoDigit, (myRidesVM.totalDistance.distance)/1000) + " Km")
                    
                }
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                HStack{
                    Text(Constants.Headings.estimatedTime)
                        
                    Spacer()
                    
                    /// to show estimated time to reach destination and conditions to check whether to show time in mins or hrs.
                    if myRidesVM.estimatedTime < 3600 {
                        Text(String(format: Constants.StringFormat.zeroDigit, myRidesVM.estimatedTime/60) + " min")
                    } else if myRidesVM.estimatedTime >= 3600 {
                        Text(String(format: Constants.StringFormat.twoDigit, myRidesVM.estimatedTime/3600) + " hr")
                    }
                    
                }
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Button {
                    myRidesVM.updateRideApiCall(dismissMethod: .itineraryDetails, method: .updatePublishedRide, httpMethod: .PUT, data: myRidesVM.toGetData(method: .itineraryDetails))
                } label: {
                    ButtonView(buttonName: Constants.ButtonsTitle.proceed, border: true)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
        .alert("Your ride has been successfully updated", isPresented: $myRidesVM.updateIsSuccess, actions: {
            Button(Constants.ButtonsTitle.okay, role: .cancel) {
                switch myRidesVM.editPublicationTypes {
                case .itineraryDetails:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        myRidesVM.toDismissRouteView = false
                    }
                    myRidesVM.toDismissItineraryDetails = false
                    //isBool = false
                    //myRidesVM.toNotShowDetails = nil
                default: break
                }
            }
        })
        
        .onChange(of: myRidesVM.toDismissRouteView) { _ in
            if !myRidesVM.toDismissRouteView {
                //DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.dismiss()
                //}
            }
        }
        /// to assign the estimate time value to another variable which is used when publishing ride so that user that is booking ride can seen the time that will be taken to rezach destination.
        .onDisappear{
            mapVM.mapView.removeAnnotations(mapVM.mapView.annotations)
            mapVM.mapView.removeOverlays(mapVM.mapView.overlays)
        }
    }
}

struct EditRouteView_Previews: PreviewProvider {
    static var previews: some View {
        EditRouteView()
            .environmentObject(MapViewModel())
            .environmentObject(CarPoolRidesViewModel())
    }
}
