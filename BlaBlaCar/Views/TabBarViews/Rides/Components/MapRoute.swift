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
        
        mapVM.addDraggablePin(coordinate: sourceCoordinate, title: "Source")
        
        mapVM.addDraggablePin(coordinate: destinationCoordinate, title: "Destination")

        map.region = region
        map.delegate = context.coordinator
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        request.requestsAlternateRoutes = true
    
        
        let directions = MKDirections(request: request)
        
        directions.calculate { directions, error in
            
            if error != nil {
                //print(error?.localizedDescription)
                return
            }
            
            myRidesVM.totalDistance = directions?.routes.first ?? MKRoute()
            carPoolVM.totalDistance = directions?.routes.first ?? MKRoute()
            
            myRidesVM.estimatedTime = directions?.routes.first?.expectedTravelTime ?? 0
            carPoolVM.estimatedTime = directions?.routes.first?.expectedTravelTime ?? 0
            
            let polyline = directions?.routes.last?.polyline
            map.addOverlay(polyline!)
            map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
        }
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
}
