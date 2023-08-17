//
//  Placemark.swift
//  BlaBlaCar
//
//  Created by Pragath on 29/06/23.
//

import Foundation
import MapKit


struct Placemark {
    
    let location: String
    let subLocation: String
    
    init(item: CLPlacemark) {
        
        var locationString: String = ""
        var mainLocationString: String = ""
        
        if let name = item.name {
            mainLocationString += "\(name)"
            locationString += "\(name)"
        }
        
        if let streetName = item.thoroughfare {
            locationString += ", \(streetName)"
        }
        
        if let locality = item.locality,
               locality != item.name {
                   mainLocationString += ", \(locality)"
                   locationString += ", \(locality)"
        }
        if let adminArea = item.administrativeArea,
            adminArea != item.locality {
                locationString += ", \(adminArea)"
        }
        
        if let postalCode = item.postalCode {
            locationString += ", \(postalCode)"
        }
        
        if let country = item.country,
           country != item.name {
              mainLocationString += ", \(country)"
              locationString += ", \(country)"
        }
        
        subLocation = locationString
        location = mainLocationString
    }
}
