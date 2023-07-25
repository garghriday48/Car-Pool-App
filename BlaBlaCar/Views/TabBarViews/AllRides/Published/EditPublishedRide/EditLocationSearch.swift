//
//  EditLocationSearch.swift
//  BlaBlaCar
//
//  Created by Pragath on 16/06/23.
//

import SwiftUI
import MapKit


struct EditLocationSearch: View {
    
    @EnvironmentObject var mapVM: MapViewModel
    @EnvironmentObject var myRidesVM: MyRidesViewModel

    
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
                                        if myRidesVM.isSource {
                                            myRidesVM.editSourceCoordinate = coordinate
                                            myRidesVM.editedSource = (name.subLocation) + ", " + (name.subLocation)
                                        }
                                        if myRidesVM.isDestination {
                                            myRidesVM.editDestCoordinate = coordinate
                                            myRidesVM.editedDestination = (name.subLocation) + ", " + (name.subLocation)
                                        }
                                    }
                                    myRidesVM.toDismissSearch.toggle()
                                } label: {
                                    LocationCell(name: name.subLocation , secondayName: name.subLocation )
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .listStyle(.plain)
                    
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
            
            /// to empty the searched result whenever the view appears.
            .onAppear{
                mapVM.searchText = myRidesVM.editedLocation
            }
            
            .onChange(of: myRidesVM.toDismissSearch, perform: { _ in
                if myRidesVM.toDismissSearch {
                    self.dismiss()
                }
            })
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
        }
        
    }
}

struct EditLocationSearch_Previews: PreviewProvider {
    static var previews: some View {
        EditLocationSearch()
            .environmentObject(MapViewModel())
            .environmentObject(MyRidesViewModel())
    }
}
