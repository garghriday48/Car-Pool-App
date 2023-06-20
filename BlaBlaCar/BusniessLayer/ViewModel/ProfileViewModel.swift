//
//  ProfileViewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    
    // MARK: variables to check and get error so as to display an alert
    @Published var hasError      = false
    @Published var errorMessage  : AuthenticateError?
    @Published var errorMessage1 = String()
    
    
    @Published var isVehicleViewSelected = false
    @Published var isGoingBack = false
    @Published var toDismissVehicleList = false
    @Published var isAddingNewVehicle = false
    @Published var toDeleteVehicle = false
    
    
    
    @Published var selectedPic: Data?
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var gender = String()
    @Published var dob = String()
    @Published var email = String()
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

    init() {
        makeEditProfileArray()
        makeVehicleOptionsArray()
    }
    
    
    ///  Function to get an array of EditProfileOptions for reusing of textfields
    func makeEditProfileArray() {
        editProfileArray = [EditProfileOptions(heading: "First Name", textField: firstName, type: .firstName, keyboardType: .default),
                            EditProfileOptions(heading: "Last Name", textField: lastName, type: .secondName, keyboardType: .default),
                            EditProfileOptions(heading: "Gender", textField: self.gender, type: .gender),
                            EditProfileOptions(heading: "Date of birth", textField: self.dob, type: .dob),
                            EditProfileOptions(heading: "Email", textField: self.email, type: .email, keyboardType: .emailAddress),
                            EditProfileOptions(heading: "Phone number", textField: self.phnNumber, type: .phnNum, keyboardType: .numberPad)]
        
    }
    
    
    /// Function to get an array of VehicleOptions for reusing of textfields
    func makeVehicleOptionsArray() {
        vehicleOptionsArray = [VehicleOptions(heading: "Country", textField: country, textFieldType: .country),
                               VehicleOptions(heading: "Name", textField: vehicleName, textFieldType: .name, keyboardType: .default),
                               VehicleOptions(heading: "Brand", textField: vehicleBrand, textFieldType: .brand, keyboardType: .default),
                               VehicleOptions(heading: "Number", textField: vehicleNumber, textFieldType: .number, keyboardType: .numberPad),
                               VehicleOptions(heading: "Type", textField: vehicleType, textFieldType: .vehicleType),
                               VehicleOptions(heading: "Color", textField: vehicleColor, textFieldType: .color),
                               VehicleOptions(heading: "Year", textField: vehicleYear, textFieldType: .year)]
    }
    
    
    /// Function to get array based on vehicleOptionSelector cases
    /// - Returns: An array of strings
    func toGetVehicleOptionsList() -> [String] {
        switch vehicleOptionSelector{
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
        case .addVehicle:
            
            return ["vehicle": ["country": addingVehicleArray[0].textField, "vehicle_number": addingVehicleArray[3].textField, "vehicle_brand": addingVehicleArray[2].textField, "vehicle_name": addingVehicleArray[1].textField, "vehicle_type": addingVehicleArray[4].textField, "vehicle_color": addingVehicleArray[5].textField, "vehicle_model_year": addingVehicleArray[6].textField]]
        case .vehicleList:
            return [:]
        case .updateVehicle:
            return ["vehicle": ["country": addingVehicleArray[0].textField, "vehicle_number": addingVehicleArray[3].textField, "vehicle_brand": addingVehicleArray[2].textField, "vehicle_name": addingVehicleArray[1].textField, "vehicle_type": addingVehicleArray[4].textField, "vehicle_color": addingVehicleArray[5].textField, "vehicle_model_year": addingVehicleArray[6].textField]]
        case .deleteVehicle:
            return [:]
        case .getVehicle:
            return [:]
        }
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

        
        anyCancellable = ApiManager.shared.apiMethodsWithDict(httpMethod: httpMethod, method: method, dataModel: data, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .failure(let error as ErrorResponse):
                    print(error)
                    if error.status?.error != nil{
                        self.errorMessage1 = error.status?.error ?? ""
                    } else {
                        self.errorMessage1 = error.status?.message ?? ""
                    }
                    
                case .failure(let error):
                    print(error)
                    self.hasError = true
                    self.errorMessage1 = error.localizedDescription
                    
                case .finished:
                    print("Completed")
                }
                
            } receiveValue: { [weak self] data in
                self?.toDismiss.toggle()
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

        anyCancellable1 = ApiManager.shared.apiMethodsWithDict(httpMethod: httpMethod, method: method, dataModel: data, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .failure(let error as ErrorResponse):
                    print(error)
                    
                case .failure(let error):
                    print(error)
                    
                case .finished:
                    print("Completed")
                }
                
            } receiveValue: { [weak self] data in
                self?.toDismiss.toggle()
                self?.vehicleResponseList = data ?? VehicleResponseList.initialize
            }

    }
    
    /// function to call API to get details of a particular vehicle for an user
    /// - Parameters:
    ///   - method: ApiVehicleMethods
    ///   - data: dictionary based on which api call is done
    ///   - httpMethod: HttpMethod like PUT, POST, etc.
    func getVehicleApiCall(method: ApiVehicleMethods, data: [String:Any]?, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))

        anyCancellable2 = ApiManager.shared.apiMethodsWithDict(httpMethod: httpMethod, method: method, dataModel: data, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .failure(let error as ErrorResponse):
                    print(error)
                    
                case .failure(let error):
                    print(error)
                    
                case .finished:
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
    
    
}



