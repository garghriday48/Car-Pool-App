//
//  MyRidesViewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 13/06/23.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation
import MapKit

class MyRidesViewModel: ObservableObject {
    
    
    // MARK: variables to check and get error so as to display an alert
    @Published var hasError      = false
    @Published var errorMessage  : AuthenticateError?
    @Published var errorMessage1 = String()
    
    @Published var updateIsSuccess = false
    
    @Published var publishWithIdSuccess = false
    @Published var navigateToPublishDetails = false
    
    @Published var rideType = RideType.booked
    
    @Published var publishListResponse = PublishListResponse.initialize
    @Published var publishResponseWithId = PublishResponseWithId.initialize
    @Published var updatedPublishedRideResponse = PublishRideResponse.initialize
    
    @Published var bookingListResponse = BookingListResponse.initialize
    
    @Published var cancelRideData = CancelRideData.initialize
    @Published var cancelRideResponse = CancelRideResponse.initialize
    
    var empty = Empty()
    
    @Published var publishId = Int()
    @Published var driverId = Int()
    @Published var idToUpdate = Int()
    
    @Published var cancelBooking = false
    @Published var isRideCancelled = false
    
    // MARK: to be used in itinerary details view
    @Published var editedDate = Date()
    @Published var editedTime = Date()
    @Published var time = String()
    @Published var toShowCalenderPicker = false
    
    @Published var editedLocation = String()
    @Published var isSource = false
    @Published var isDestination = false
    @Published var toDismissSearch = false
    
    // MARK: to get the coordinatees of source and destination
    @Published var editSourceCoordinate = CLLocationCoordinate2D(latitude: 30.7046, longitude: 76.7179)
    @Published var editDestCoordinate = CLLocationCoordinate2D(latitude: 30.7046, longitude: 76.7179)
    @Published var editedSource = String()
    @Published var editedDestination = String()
    
    // MARK: to get updated price for published ride
    @Published var updatedPrice = String()
    @Published var updatedSeats = Int()
    // Array consisting of routes
    @Published var totalDistance = MKRoute()
    @Published var estimatedTime = TimeInterval()
    
    @Published var toDismissEditView = false
    @Published var toDismissRouteView = false
    @Published var toNotShowDetails: Int?
    
    @Published var editPublicationTypes = EditPublicationTypes.itineraryDetails
    
    private var anyCancellable: AnyCancellable?
    private var anyCancellable1: AnyCancellable?
    private var anyCancellable2: AnyCancellable?
    
    
    func toGetData(method: EditPublicationTypes) -> [String: Any] {
        switch method {
        case .itineraryDetails:
            return [Constants.DictionaryForApiCall.publish: [Constants.DictionaryForApiCall.date: editedDate.formatted(date: .abbreviated, time: .omitted), Constants.DictionaryForApiCall.time:  editedTime.formatted(date: .omitted, time: .shortened), Constants.DictionaryForApiCall.sourceLat: editSourceCoordinate.latitude, Constants.DictionaryForApiCall.sourceLong: editSourceCoordinate.longitude, Constants.DictionaryForApiCall.destLat: editDestCoordinate.latitude, Constants.DictionaryForApiCall.destLong: editDestCoordinate.longitude, Constants.DictionaryForApiCall.source: editedSource, Constants.DictionaryForApiCall.destination: editedDestination, Constants.DictionaryForApiCall.estimatedTime: DateTimeFormat.shared.toConvertDate(seconds: Int(estimatedTime))]]
        case .price:
            return [Constants.DictionaryForApiCall.publish: [Constants.DictionaryForApiCall.price: updatedPrice]]
        case .seats:
            return [Constants.DictionaryForApiCall.publish: [Constants.DictionaryForApiCall.count: "\(updatedSeats)"]]
        }
    }
    
    /// function to get url based on different methods
    func toGetURL(method: ApiMyRidesMethods) -> String{
        switch method {
        case .publishList:
            return Constants.Url.baseURL + Constants.Url.publishRide
        case .publishById:
            return Constants.Url.baseURL + Constants.Url.publishById + "\(publishId)"
        case .bookingList:
            return Constants.Url.baseURL + Constants.Url.bookingList
        case .cancelRide:
            return Constants.Url.baseURL + Constants.Url.cancelRide
        case .updatePublishedRide:
            return Constants.Url.baseURL + Constants.Url.publishRide + "/\(idToUpdate)"
        case .cancelPublishedRide:
            return Constants.Url.baseURL + Constants.Url.cancelPublishedRide
        }
    }
    
    
    /// function to call API that is used to get all the published rides by the user
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func publishRideApiCall(method: ApiMyRidesMethods, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true

        anyCancellable = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: empty, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error as ErrorResponse):
                    ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    print("completed")
                }
                
            } receiveValue: { [weak self] data in
                self?.publishListResponse = data ?? PublishListResponse.initialize
                print(self?.publishListResponse as Any)
            }

    }
    
    /// function to call API that is used to get data of a publishede ride using id
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func publishWithIdApiCall(method: ApiMyRidesMethods, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: empty, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error as ErrorResponse):
                    ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    self.publishWithIdSuccess = true
                }
            } receiveValue: { [weak self] data in

                self?.publishResponseWithId = data ?? PublishResponseWithId.initialize
                print(self?.publishResponseWithId as Any)
            }

    }
    
    /// function to call API that is used to get data of all the rides booked by the user.
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func bookingRideApiCall(method: ApiMyRidesMethods, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable1 = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: empty, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error as ErrorResponse):
                    ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    print("completed")
                }
            } receiveValue: { [weak self] data in

                self?.bookingListResponse = data ?? BookingListResponse.initialize
                print(self?.bookingListResponse as Any)
            }

    }
    
    /// function to call API that is used to cancel the selected ride that has been booked already.
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func cancelRideApiCall(method: ApiMyRidesMethods, httpMethod: HttpMethod){
        
        isRideCancelled = false
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: cancelRideData, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error as ErrorResponse):
                    ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    self.isRideCancelled = true
                    self.cancelBooking = false
                    
                }
            } receiveValue: { [weak self] data in
                self?.cancelRideResponse = data ?? CancelRideResponse.initialize
                print(self?.cancelRideResponse as Any)
            }

    }
    
    /// function to call API that is used to update the any published ride
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    ///   - data: gives the dictionary
    func updateRideApiCall(dismissMethod: EditPublicationTypes, method: ApiMyRidesMethods, httpMethod: HttpMethod, data: [String: Any]? ){
        
        updateIsSuccess = false
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable2 = ApiManager.shared.apiMethodsWithDict(httpMethod: httpMethod, method: method, dataModel: data, url: url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error as ErrorResponse):
                    ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    
                    self?.updateIsSuccess = true
                    self?.publishWithIdApiCall(method: .publishById, httpMethod: .GET)
                    
                }
                
            } receiveValue: { [weak self] data in
                self?.updatedPublishedRideResponse = data ?? PublishRideResponse.initialize
                print(self?.updatedPublishedRideResponse as Any)
            }

    }
    
    func toSetBookingType(type: String, bookedTab: Bool) -> (String, Color){
        var rideType = ("", Color.white)
        
        if bookedTab{
            switch RideBookedType(rawValue: type){
            case .CONFIRM : rideType = (Constants.Description.confirmed, Color.green)
            case .CANCEL : rideType = (Constants.Description.cancelled, Color.red)
            case .CancelByDriver : rideType = (Constants.Description.cancelByDriver, Color.red)
            case .none: break
            }
        } else {
            switch RidePublishedType(rawValue: type){
            case .confirm: rideType = (Constants.Description.completed, Color.green)
            case .pending: rideType = (Constants.Description.pending, Color.yellow)
            case .cancel: rideType = (Constants.Description.cancelled, Color.red)
            case .none: break
            }
        }
        return rideType
    }
}
