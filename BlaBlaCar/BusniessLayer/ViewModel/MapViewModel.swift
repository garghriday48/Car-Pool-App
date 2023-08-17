//
//  MapViewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 24/05/23.
//

import Foundation
import MapKit
import Combine

class MapViewModel: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    
    static let mapVM = MapViewModel()
    
    // MARK: properties
    @Published var mapView: MKMapView = .init()
    @Published var mapType: MKMapType = .standard
    @Published var locationManager: CLLocationManager = .init()
    
    // MARK: search bar
    @Published var searchText = ""
    var cancellable: AnyCancellable?
    @Published var fetchedPlaces: [CLPlacemark]?
    
    // MARK: user location
    @Published var userLocation: CLLocation?
    @Published var userDropLocation: CLLocation?
    
    // MARK: final location
    @Published var pickedLocation: CLLocation?
    @Published var pickedPlacemark: CLPlacemark?
    
    @Published var updatedPlacemark: CLPlacemark?
    @Published var mapRoutes: [MKRoute]?
    @Published var isFirstRoute = false
    
    // MARK: whether to show map or not
    @Published var toShowMap: Bool = false

    // MARK: to show alert for denied permissions
    @Published var permissionDenied = false
    
    
    private let request = MKLocalSearch.Request()
    private var localSearch: MKLocalSearch?
    
    override init() {
        super.init()
        
        mapView.delegate = self
        locationManager.delegate = self
        

        
        // MARK: search textfield watching (using combine)
        cancellable = $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                if value != "" {
                    self?.fetchValue(value: value)
                } else {
                    self?.fetchedPlaces = nil
                }
                
            })
    }
    
    // MARK: update map type
    func updateMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    func searchPlace(_ place: String) {
            
        }
    
    // MARK: function to fetch place using MKLocalSearch
    func fetchValue(value: String) {
       Task {
           do {
               localSearch?.cancel()
               
               request.naturalLanguageQuery = value
               localSearch = MKLocalSearch(request: request)
               localSearch?.start { [weak self] searchResponse, _  in
//                   guard let items = searchResponse?.mapItems else {
//                          return
//                      }
//                   self?.fetchedPlaces = items
                   self?.fetchedPlaces = searchResponse?.mapItems.compactMap({ item -> CLPlacemark? in
                       return item.placemark
                   })
               }
           }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // MARK: handle errors
        print(error.localizedDescription)
        print("location is not getting fetched from map.")
    }
    
    private func checkLocationAuthorization() {
        //guard let locationManager = locationManager else {return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            //locationManager.requestLocation()
        case .restricted:
            print("restricted")
        case .denied:
            print("restricted123")
            permissionDenied.toggle()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        self.userLocation = currentLocation
        
    }
    
    
    // MARK: add draggable pin to mapView
    func addDraggablePin(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        
        mapView.addAnnotation(annotation)
    }
    
    // MARK: enable dragging
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "LocationPin")
        marker.isDraggable = true
        marker.canShowCallout = false

        return marker
    }
    

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        guard let newLocation = view.annotation?.coordinate else { return }
        
        self.pickedLocation = .init(latitude: newLocation.latitude, longitude: newLocation.longitude)
        updatePlacemark(location: .init(latitude: newLocation.latitude, longitude: newLocation.longitude))
    }
    
    func updatePlacemark(location: CLLocation) {
        Task{
            do{
                guard let place = try await newLocationCoordinates(location: location) else { return }
                DispatchQueue.main.async {
                    self.pickedPlacemark = place
                    
                }
            } catch {
                //HANDLE ERROR
            }
        }
    }
    
    // MARK: displaying new location data
    
    func newLocationCoordinates(location: CLLocation) async throws -> CLPlacemark? {
        let place = try await CLGeocoder().reverseGeocodeLocation(location).first
        return place
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = self.isFirstRoute ? .red : .gray
        render.lineWidth = 7
        
        
        return render
        
    }
    

}
