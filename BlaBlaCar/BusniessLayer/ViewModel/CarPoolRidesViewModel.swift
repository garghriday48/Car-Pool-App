//
//  CarPoolRidesViewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import Foundation
import UIKit
import Combine
import CoreLocation
import MapKit
import SwiftUI


class CarPoolRidesViewModel: ObservableObject {
    
    
    // MARK: To select between booking or offering ride
    @Published var rideMethod: RideMethods = .bookingRide
    
    // MARK: to check whether pickup or drop location of driver and passenger is empty
    @Published var pickupLocationIsEmpty = false
    @Published var pickupLocation = Constants.TextfieldPlaceholder.pickupLocation
    @Published var driverPickupLocation = Constants.TextfieldPlaceholder.pickupLocation
    
    @Published var dropLocationIsEmpty = false
    @Published var dropLocation = Constants.TextfieldPlaceholder.dropLocation
    @Published var driverDropLocation = Constants.TextfieldPlaceholder.dropLocation
    
    // MARK: to get the coordinatees of source and destination
    @Published var offerSourceCoordinate = CLLocationCoordinate2D(latitude: 30.7046, longitude: 76.7179)
    @Published var sourceCoordinate = CLLocationCoordinate2D(latitude: 30.7046, longitude: 76.7179)

    @Published var offerDestinationCoordinate = CLLocationCoordinate2D(latitude: 30.7046, longitude: 76.7179)
    @Published var destinationCoordinate = CLLocationCoordinate2D(latitude: 30.7046, longitude: 76.7179)
    
    // Array consisting of routes
    @Published var totalDistance = MKRoute()
    @Published var estimatedTime = TimeInterval()
    //to check whether calender is shown or not
    @Published var toShowCalenderPicker = false
    @Published var departureDate = Date()
    @Published var publishingDate = Date()
    
      
    @Published var offerRideSelectorArray: [OfferRideSelectorOptions] = []
    @Published var offerRideSelector: OfferRideSelector = .SelectVehicle
    @Published var locationDetails = []
    
    // MARK: to check the filter are applied or not
    @Published var filterAndSort = false
    @Published var lowestPrice = false
    @Published var earliestDeparture = false
    @Published var shortestRide = false
    @Published var bookInstantly = false
    @Published var filtersArray: [FilterData] = []
    @Published var selectedPosition = -1
    
    // MARK: to show details when booking ride
    @Published var isRideDetails = true
    @Published var isSeatSelected = false
    @Published var toShowSeatSelector = false
    @Published var numOfSeats = 1
    @Published var numOfSeatsPublish = 1
    @Published var numOfSeatsSelected = Int()

    // MARK: to get maximum and minimum price based on screen size
    @Published var minRidePrice: CGFloat = 0
    @Published var maxRidePrice: CGFloat = UIScreen.main.bounds.width - 80
    var totalWidth = UIScreen.main.bounds.width - 80

    // MARK: data models
    @Published var publishRideData = PublishRideData.initialize
    @Published var rideSearchData = RideSearchData.initialize
    @Published var bookRideData = BookRideData.initialize
    
    @Published var publishRideResponse = PublishRideResponse.initialize
    @Published var rideSearchResponse = RideSearchResponse.initialize
    @Published var bookRideResponse = BookRideResponse.initialize
    
    @Published var searchApiSuccess = false
    @Published var bookApiSuccess = false
    
    @Published var navigateToMapRoute = false
    @Published var toShowSearchDetails = false
    @Published var RecentSearchesData: [DataArray] = []
    
    // MARK: computed property to disable button when conditions are not met
    var disableButton: Bool {
        rideMethod == .offeringRide ? offerRideSelectorArray[0].text.isEmpty || offerRideSelectorArray[1].text.isEmpty || offerRideSelectorArray[2].text.isEmpty || driverPickupLocation == Constants.TextfieldPlaceholder.pickupLocation || driverDropLocation == Constants.TextfieldPlaceholder.dropLocation : pickupLocation == Constants.TextfieldPlaceholder.pickupLocation || dropLocation == Constants.TextfieldPlaceholder.dropLocation || numOfSeats == 0
    }
    
    private var anyCancellable: AnyCancellable?
    private var anyCancellable1: AnyCancellable?
    
    private var searchRideUrl: String {
        var url = Constants.Url.baseURL + Constants.Url.searchRide
        url += "\(Constants.APIConstants.sourceLon)=\(rideSearchData.sourceLongitude)"
        url += "&\(Constants.APIConstants.sourceLat)=\(rideSearchData.sourceLatitude)"
        url += "&\(Constants.APIConstants.destLon)=\(rideSearchData.destinationLongitude)"
        url += "&\(Constants.APIConstants.destLat)=\(rideSearchData.destinationLatitude)"
        url += "&\(Constants.APIConstants.passCount)=\(rideSearchData.passCount)"
        url += "&\(Constants.APIConstants.date)=\(rideSearchData.date)"
        return url
    }
    
    init() {
        OfferRide()
        filterSelection()
        

    }
    
    
    /// Function to get a Array of OfferRideSelectorOptions for reusability purposes
    func OfferRide(){
        offerRideSelectorArray = [OfferRideSelectorOptions(heading: Constants.Headings.selectVehicle, text: "", isSelected: false, image: Constants.Images.car),
                                  OfferRideSelectorOptions(heading: Constants.Headings.availableSeats, text: publishRideData.publish.passengersCount, isSelected: false, image: Constants.Images.seat),
                                  OfferRideSelectorOptions(heading: Constants.Headings.perSeatPrice, text: publishRideData.publish.setPrice, isSelected: false, image: Constants.Images.rupeeSign)]
        
    }
    
    /// Function to get a Array of FilterData for reusability purposes of filters
    func filterSelection() {
        filtersArray = [FilterData(name: Constants.ButtonsTitle.lowestPrice, image: Constants.Images.rupeeSign, isSelected: self.lowestPrice, order: "2"),
                        
                        FilterData(name: Constants.ButtonsTitle.earliestDeparture, image: Constants.Images.clock, isSelected: self.earliestDeparture, order: "1")]
    }

    
    /// Function to convert a value to a string that contains no decimal points
    /// - Parameter value: A CGFloat value
    /// - Returns: A string that contains no decimal points
    func getValue(value: CGFloat, format: String) -> String {
        return String(format: format, value)
    }
    
    
    /// function to get url based on different methods
    func toGetURL(method: ApiRideMethods) -> String{
        switch method {
        case .publishRide:
            return Constants.Url.baseURL + Constants.Url.publishRide
        case .searchRide:
            return searchRideUrl
        case .bookRide:
            return Constants.Url.baseURL + Constants.Url.bookRide
        case .searchRideByOrder:
            guard let order = rideSearchData.order else { return ""}
            var newUrl = searchRideUrl
            newUrl += "&\(Constants.APIConstants.order)=\(order)"
            return newUrl
        }
    }
    
    
    /// function to call API that are related to publishRideData
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func publishRideApiCall(method: ApiRideMethods, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: publishRideData, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {

                case .failure(let error as ErrorResponse):
                    ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    NavigationViewModel.navigationVM.pop(to: .TabBarPage)
                }
                
            } receiveValue: { [weak self] data in

                self?.publishRideResponse = data ?? PublishRideResponse.initialize
                print(self?.publishRideResponse as Any)
            }

    }
    
    
    /// function to call API that are related to rideSearchData
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func searchRideApiCall(method: ApiRideMethods, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: rideSearchData, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .failure(let error as ErrorResponse):
                    ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    print("Completed")
                    switch method {
                    case .searchRide:
                        NavigationViewModel.navigationVM.push(.carPoolBook)
                    default: break
                    }
                }
                
            } receiveValue: { [weak self] data in
                self?.rideSearchResponse = data ?? RideSearchResponse.initialize
                print(self?.rideSearchResponse as Any)
                
                //self?.searchApiSuccess.toggle()
            }

    }
    
    /// function to call API that are related to bookRideData
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func bookRideApiCall(method: ApiRideMethods, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: bookRideData, url: url)
            .receive(on: DispatchQueue.main)
            .sink { [self] completion in
                switch completion {
                case .failure(let error as ErrorResponse):
                    ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    self.bookApiSuccess.toggle()

                }
                
            } receiveValue: { [weak self] data in
                self?.bookRideResponse = data ?? BookRideResponse.initialize
                print(self?.bookRideResponse as Any)
            }

    }
    
    /// function to set coordinates that we get during searching
    /// which are then used to either search or publish ride
    func toSetCoordinates() {
        publishRideData.publish.sourceLatitude = sourceCoordinate.latitude
        publishRideData.publish.sourceLongitude = sourceCoordinate.longitude
        publishRideData.publish.destinationLatitude = destinationCoordinate.latitude
        publishRideData.publish.destinationLongitude = destinationCoordinate.longitude
        
        rideSearchData.sourceLatitude = offerSourceCoordinate.latitude
        rideSearchData.sourceLongitude = offerSourceCoordinate.longitude
        rideSearchData.destinationLatitude = offerDestinationCoordinate.latitude
        rideSearchData.destinationLongitude = offerDestinationCoordinate.longitude
    }
    
    /// function to reset values 
    func resetPublishRideValues() {
        driverDropLocation = Constants.TextfieldPlaceholder.dropLocation
        driverPickupLocation = Constants.TextfieldPlaceholder.pickupLocation
        publishingDate = Date()
        numOfSeats = Int()
        
        for i in 0...2 {
            offerRideSelectorArray[i].text = String()
        }
    }
    
    /// function to reset values
    func resetSearchRideValues() {
        dropLocation = Constants.TextfieldPlaceholder.dropLocation
        pickupLocation = Constants.TextfieldPlaceholder.pickupLocation
        departureDate = Date()
        numOfSeats = Int()
    }
    
    
}
