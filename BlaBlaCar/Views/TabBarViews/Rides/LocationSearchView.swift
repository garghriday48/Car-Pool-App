//
//  MapView.swift
//  BlaBlaCar
//
//  Created by Pragath on 24/05/23.
//

import SwiftUI
import MapKit

struct LocationSearchView: View {
    
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    @ObservedObject var mapVM: MapViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    /// back arrow to navigate back to other view present in navigation stack.
                    BackButton(image: Constants.Images.backArrow) {
                        self.dismiss()
                    }
                    .font(.title)
                    .bold()
                    
                    Text(Constants.Headings.searchLocation)
                        .font(.title3)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity ,alignment: .topLeading)
                }
                .padding()
                
                HStack(spacing: 10){
                    Image(systemName: Constants.Images.magnifyingGlass)
                        .foregroundColor(.gray)
                    
                    /// textfield to search for the location entered by the user
                    TextField(Constants.TextfieldPlaceholder.findLocation, text: $mapVM.searchText)
                        .autocorrectionDisabled()
                    if !mapVM.searchText.isEmpty {
                        Button(action:
                        {
                            mapVM.searchText = ""
                        })
                        {
                            Image(systemName: Constants.Images.crossFill)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(.gray)
                )
                .padding(.vertical,10)
                
                
                if let places = mapVM.fetchedPlaces, !places.isEmpty {
                    List{
                        
                            /// to show all the places based on the searching done by user.
                            ForEach(places, id: \.self){place in
                                if let name = Placemark(item: place){
                                /// whenever any searched location is tapped a map is shown that shows the searched location on map with also having a pin.
                                Button {
                                    if let coordinate = place.location?.coordinate {
                                        
                                        mapVM.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                        mapVM.mapView.region = .init(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                                        mapVM.addDraggablePin(coordinate: coordinate, title: Constants.Headings.selectedLocation)
                                        mapVM.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                    }
                                    /// to show map
                                    mapVM.toShowMap.toggle()
                                } label: {
                                    LocationCell(name: name.location, secondayName: name.subLocation)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .listStyle(.plain)
                } else {

                    // MARK: live location button
                    Button {
                        
                        if let coordinate = mapVM.userLocation?.coordinate {
                            mapVM.mapView.region = .init(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                            mapVM.addDraggablePin(coordinate: coordinate, title: Constants.Headings.selectedLocation)
                            mapVM.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                        }
                        mapVM.toShowMap.toggle()
                    } label: {
                        Label {
                            Text(Constants.ButtonsTitle.currentLocation)
                        } icon: {
                            Image(systemName: Constants.Images.locationPointer)
                        }
                        .foregroundColor(Color(Color.redColor))
                        
                    }
                    .frame(maxWidth: .infinity ,alignment: .leading)
                }
                
            }
            /// alert is used to show if permission to show map is not given.
            .alert(isPresented: $mapVM.permissionDenied) {
                Alert (title: Text(Constants.Headings.permissionDenied),
                       message: Text(Constants.Description.PermissionInSettigs),
                       primaryButton: .default(Text(Constants.ButtonsTitle.settings), action: {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }),
                       secondaryButton: .default(Text(Constants.ButtonsTitle.cancel)))
                    }
            
            /// sheet to show map whenever the searched location is tapped.
            .sheet(isPresented: $mapVM.toShowMap, content: {
                MapView(mapVM: mapVM, carPoolVM: carPoolVM)
            })
            
            /// to empty the searched result whenever the view appears.
            .onAppear{
                mapVM.searchText = ""
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
        }
        
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(carPoolVM: CarPoolRidesViewModel(), mapVM: MapViewModel()
        )
    }
}
