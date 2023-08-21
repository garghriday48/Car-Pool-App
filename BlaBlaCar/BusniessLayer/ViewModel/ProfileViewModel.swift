//
//  ProfileViewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import Foundation
import Combine
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    
    @Published var isVehicleViewSelected = false
    @Published var isGoingBack = false
    //@Published var toDismissVehicleList = false
    @Published var isAddingNewVehicle = false
    @Published var toDeleteVehicle = false
    
    
    
    @Published var selectedPic: Data?
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var gender = ""
    @Published var dob = ""
    @Published var email = ""
    @Published var phnNumber = ""
    
    @Published var vehicleName = String()
    @Published var vehicleNumber = String()
    @Published var vehicleBrand = String()
    @Published var vehicleType = String()
    @Published var vehicleColor = String()
    @Published var vehicleYear = String()
    @Published var country = String()
    @Published var vehicleId = String()

    // MARK: model data
    @Published var addingVehicleData = AddingVehicleData.initialize
    @Published var vehicleResponse = VehicleResponse.initialize
    @Published var vehicleResponseList = VehicleResponseList.initialize
    @Published var getVehicleData = VehicleData.initialize
    
    //@Published var vehicleDict: [String: Any]?
    
    @Published var vehicleOptionSelector = VehicleTextFieldType.country
    
    @Published var toShowVehicleOptionsList = false
    @Published var isTextfieldEnabled = false
    @Published var isDatePicker = false
    @Published var toShowPicker = false
    @Published var selectedIndex    = -1
    
    @Published var myDate           = Date()
    @Published var vehicleDate      = Date()
    
    var editProfileArray: [EditProfileOptions] = []
    
    
    var vehicleOptionsArray: [VehicleOptions] = []
    @Published var addingVehicleArray: [VehicleOptions] = []
    
    @Published var vehicleListArray: [VehicleData] = []

    private var anyCancellable: AnyCancellable?
    private var anyCancellable1: AnyCancellable?
    private var anyCancellable2: AnyCancellable?
    
    @Published var toDismiss = false
    
    
    

    
    @Published var otpText = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 4)
    

    init() {
        makeEditProfileArray()
        makeVehicleOptionsArray()
    }
    
    
    ///  Function to get an array of EditProfileOptions for reusing of textfields
    func makeEditProfileArray() {
        editProfileArray = [EditProfileOptions(heading: Constants.TextfieldReuse.firstName, textField: firstName, type: .firstName, keyboardType: .default, capitalizationType: .words),
                            EditProfileOptions(heading: Constants.TextfieldReuse.lastName, textField: lastName, type: .secondName, keyboardType: .default, capitalizationType: .words ),
                            EditProfileOptions(heading: Constants.TextfieldReuse.gender, textField: gender, type: .gender),
                            EditProfileOptions(heading: Constants.TextfieldReuse.dob, textField: dob, type: .dob),
                            EditProfileOptions(heading: Constants.TextfieldReuse.email, textField: email, type: .email, keyboardType: .emailAddress, capitalizationType: .never),
                            EditProfileOptions(heading: Constants.TextfieldReuse.phoneNum, textField: phnNumber, type: .phnNum, keyboardType: .numberPad, capitalizationType: .never)]
        
    }
    
    
    /// Function to get an array of VehicleOptions for reusing of textfields
    func makeVehicleOptionsArray() {
        vehicleOptionsArray = [VehicleOptions(heading: Constants.TextfieldReuse.country, textField: country, textFieldType: .country),
                               VehicleOptions(heading: Constants.TextfieldReuse.name, textField: vehicleName, textFieldType: .name, keyboardType: .default, capitalizationType: .words),
                               VehicleOptions(heading: Constants.TextfieldReuse.brand, textField: vehicleBrand, textFieldType: .brand, keyboardType: .default, capitalizationType: .words),
                               VehicleOptions(heading: Constants.TextfieldReuse.number, textField: vehicleNumber, textFieldType: .number, keyboardType: .default, capitalizationType: .never),
                               VehicleOptions(heading: Constants.TextfieldReuse.type, textField: vehicleType, textFieldType: .vehicleType),
                               VehicleOptions(heading: Constants.TextfieldReuse.color, textField: vehicleColor, textFieldType: .color),
                               VehicleOptions(heading: Constants.TextfieldReuse.year, textField: vehicleYear, textFieldType: .year)]
    }
    
    
    /// Function to get array based on vehicleOptionSelector cases
    /// - Returns: An array of strings
    func toGetVehicleOptionsList(method: VehicleTextFieldType) -> [String] {
        switch method{
        case .name, .brand, .number:
            return []
        case .country:
            return VehiclesData.countries
        case .year:
            return VehiclesData.getYearsList()
        case .vehicleType:
            return VehiclesData.vehicleType
        case .color:
            return VehiclesData.vehicleColor
        }
    }
    
    
    
    /// function to make dictionaries based on ApiVehicleMethods used for api call
    /// - Parameter method: ApiVehicleMethods
    /// - Returns: dictionary of type [String: Any]
    func makeDict(method: ApiVehicleMethods) -> [String:Any] {
        switch method {
        case .addVehicle: return self.toGiveVehicleDict()
        case .updateVehicle: return self.toGiveVehicleDict()
        default: return [:]
        }
    }
    
    func toGiveVehicleDict() -> [String:Any] {
        return [Constants.DictionaryForApiCall.vehicle: [Constants.DictionaryForApiCall.country: addingVehicleArray[0].textField, Constants.DictionaryForApiCall.vehicleNum: addingVehicleArray[3].textField, Constants.DictionaryForApiCall.vehicleBrand: addingVehicleArray[2].textField, Constants.DictionaryForApiCall.vehicleName: addingVehicleArray[1].textField, Constants.DictionaryForApiCall.vehicleType: addingVehicleArray[4].textField, Constants.DictionaryForApiCall.vehicleColor: addingVehicleArray[5].textField, Constants.DictionaryForApiCall.vehicleYear: addingVehicleArray[6].textField]]
    }
    
    /// function to get URLs for all ApiVehicleMethods for api call
    /// - Parameter method: ApiVehicleMethods
    /// - Returns: an Url of type string
    func toGetURL(method: ApiVehicleMethods) -> String{
        switch method {
        case .addVehicle:
            return Constants.Url.baseURL + Constants.Url.addVehicle
        case .vehicleList:
            return Constants.Url.baseURL + Constants.Url.addVehicle
        case .updateVehicle:
            let url = Constants.Url.baseURL + Constants.Url.updateVehicle + self.vehicleId
            return url
        case .deleteVehicle:
            let url = Constants.Url.baseURL + Constants.Url.updateVehicle + self.vehicleId
            return url
        case .getVehicle:
            let url = Constants.Url.baseURL + Constants.Url.getVehicle + self.vehicleId
            return url
        }
    }
    
    /// function to call api that have same response as vehicleResponse
    /// - Parameters:
    ///   - method: ApiVehicleMethods
    ///   - data: dictionary based on which api call is done
    ///   - httpMethod: HttpMethod like PUT, POST, etc.
    func vehicleApiCall(method: ApiVehicleMethods, data: [String:Any]?, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable = ApiManager.shared.apiMethodsWithDict(httpMethod: httpMethod, method: method, dataModel: data, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .failure(let error as ErrorResponse):
                    ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                }
                
            } receiveValue: { [weak self] data in
                //self?.toDismiss.toggle()
                switch method {
                case .addVehicle:
                    self?.toDismiss = true
                case .updateVehicle:
                    self?.toDismiss = true
                default: break
                    
                }
                self?.vehicleResponse = data ?? VehicleResponse.initialize
                print(self?.vehicleResponse as Any)
            }

    }
    
    
    /// function to call an api to get a list of all vehicle used by a particular user
    /// - Parameters:
    ///   - method: ApiVehicleMethods
    ///   - data: dictionary based on which api call is done
    ///   - httpMethod: HttpMethod like PUT, POST, etc.
    func vehicleListApiCall(method: ApiVehicleMethods, data: [String:Any]?, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable1 = ApiManager.shared.apiMethodsWithDict(httpMethod: httpMethod, method: method, dataModel: data, url: url)
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
                }
                
            } receiveValue: { [weak self] data in
                self?.toDismiss.toggle()
                self?.vehicleResponseList = data ?? VehicleResponseList.initialize
                print(self?.vehicleResponseList as Any)
            }

    }
    
    /// function to call API to get details of a particular vehicle for an user
    /// - Parameters:
    ///   - method: ApiVehicleMethods
    ///   - data: dictionary based on which api call is done
    ///   - httpMethod: HttpMethod like PUT, POST, etc.
    func getVehicleApiCall(method: ApiVehicleMethods, data: [String:Any]?, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable2 = ApiManager.shared.apiMethodsWithDict(httpMethod: httpMethod, method: method, dataModel: data, url: url)
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
                }
                
            } receiveValue: { [weak self] data in
                self?.toDismiss.toggle()
                self?.getVehicleData = data ?? VehicleData.initialize
            }

    }
    
    
    /// function to set variables related to vehicle data that are then used to update vehicle details
    /// - Parameter data: VehicleData that we get from api call
    func toSetVehicleOptions(data: VehicleData) {
        vehicleName = data.vehicleName
        vehicleNumber = data.vehicleNumber
        vehicleBrand = data.vehicleBrand
        vehicleType = data.vehicleType
        vehicleColor = data.vehicleColor
        vehicleYear = String(data.vehicleModelYear)
        country = data.country
    }
    
    
    /// function to reset variables related to vehicle details
    func resetVehicleOptions() {
        vehicleName = String()
        vehicleNumber = String()
        vehicleBrand = String()
        vehicleType = String()
        vehicleColor = String()
        vehicleYear = String()
        country = String()
    }
    
    func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        default: return .field4
        }
    }
    
    // MARK: conditions for custom OTP field and limiting it to only one text
    func OTPCondition(value: [String]) {
        
        for index in 0..<4 where value[index].count > 1 {
            otpFields[index] = String(value[index].last!)
        }
    }
    
    // MARK: to check that no otp field should be empty
    func checkStates() -> Bool {
        for index in 0..<4 where otpFields[index].isEmpty { return false }
        return true
    }
}



