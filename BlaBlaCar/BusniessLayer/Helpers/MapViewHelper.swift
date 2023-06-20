//
//  MapViewHelper.swift
//  BlaBlaCar
//
//  Created by Pragath on 24/05/23.
//

import Foundation
import SwiftUI
import MapKit


struct MapViewHelper: UIViewRepresentable {
    
    @ObservedObject var mapVM: MapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        return mapVM.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

