//
//  MapRoute.swift
//  BlaBlaCar
//
//  Created by Pragath on 25/05/23.
//

import Foundation
import MapKit
import SwiftUI


struct MapRoute: UIViewRepresentable {
    
    
    var sourceCoordinate: CLLocationCoordinate2D
    var destinationCoordinate: CLLocationCoordinate2D

    
    func makeCoordinator() -> MapViewModel {
        return mapVM
    }
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @ObservedObject var mapVM: MapViewModel
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        
        let map = mapVM.mapView
        let region = MKCoordinateRegion(center: sourceCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        
        // To add pins of source and destination according to coordinates
        mapVM.addDraggablePin(coordinate: sourceCoordinate, title: "Source")
        
        mapVM.addDraggablePin(coordinate: destinationCoordinate, title: "Destination")

        map.region = region
        map.delegate = context.coordinator
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
    
        
        let directions = MKDirections(request: request)
        
        
        directions.calculate { response, error in
            if error != nil{
//                        self.showAlert(message: "Route not found")
                return
            }
            guard let mapRoutes = response?.routes else {
                return
            }
            
            mapVM.mapRoutes = mapRoutes
            
            for route in response!.routes{
                
                if route == response!.routes.last {
                    mapVM.isFirstRoute = true
                } else {mapVM.isFirstRoute = false}
                let polyline = route.polyline
                
                // To add overlays in map to show route between source and destination
                map.addOverlay(polyline)
                map.setRegion(MKCoordinateRegion(polyline.boundingMapRect), animated: true)
                
                // To get estimated time and distance of a selected route
                myRidesVM.totalDistance = route
                carPoolVM.totalDistance = route
                
                myRidesVM.estimatedTime = route.expectedTravelTime
                carPoolVM.estimatedTime = route.expectedTravelTime
            }
        }
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
}
