//
//  MainVIewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import Foundation
import Combine

class SignInSignUpViewModel: ObservableObject {
    
    
    static var shared = SignInSignUpViewModel()
    
    @Published var updateProfileDone = false
    
    // MARK: variables to check and get error so as to display an alert
    @Published var hasError      = false
    @Published var hasResponseError = false
    @Published var errorMessage  : AuthenticateError?
    @Published var errorMessage1 = String()
    
    
    // MARK: to show loader
    
    @Published var isLoading = false
    @Published var loaderLoading = false
    
    // to check if user needs to signIn or signUp
    @Published var isNewUser              = false
    
    // to check whether picker is disable or not
    @Published var toShowPicker           = false
    
    // to check whether the picker is datePicker or not
    @Published var isDatePicker           = true
    
    // to check whether to go back to main page
    @Published var isGoingBackToMainPage  = false
    
    // to display loading button
    @Published var isLoadingButton        = false
    
    // to get different views based on selection
    @Published var signUpViews: SignUpViewsEnum = .emailPasswordView
    
    @Published var userAuthData = UserAuthData(user: User(email: String(), password: String(), firstName: String(), lastName: String(), dob: String(), title: String()))
    
    @Published var updatingUserArray: [EditProfileOptions] = []
    @Published var updateBio = String()
    
    @Published var userResponse = UserResponse.initializeData
    @Published var forgotPasswordResponse = ForgotPasswordResponse.initialize
    @Published var profileResponse = ProfileDetails.initializeData
    
    @Published var selectedIndex    = -1
    @Published var emailValid       = String()
    @Published var passValid        = String()
    @Published var confirmPass      = String()
    @Published var firstNameValid   = String()
    @Published var lastNameValid    = String()
    @Published var myDate           = Date()
    @Published var nameValid        = String()
    @Published var phoneNumValid    = String()
    
    @Published var phoneNum: String = ""
    
    @Published var editPhotos = false
    @Published var openPhotosPicker = false
    
    @Published var userId = Int()
    
    // for changing of password
    @Published var changePassword = ChangePassword.initialize
    @Published var toShowChangePassword = false
    
    @Published var forgotPasswordView: ForgotPasswordViews = .email
    @Published var typeOfOtp: TypeOfOtp = .forgotPassword
    
    @Published var forgotPassEmail = String()
    @Published var otp = String()
    
    private var anyCancellable: AnyCancellable?
    private var anyCancellable1: AnyCancellable?
    
    // MARK: variable to check for validations on email
    var emailPassBtnDisable: Bool {
        !self.emailValid.isEmpty || !self.passValid.isEmpty || self.userAuthData.user.email.isEmpty || self.userAuthData.user.password.isEmpty
    }
    
    // MARK: variable to check for validations on changing password
    var changePasswordBtnDisable: Bool {
        !self.passValid.isEmpty || self.changePassword.password.isEmpty || self.changePassword.password != self.changePassword.password_confirmation
    }
    
    // MARK: variable to check for validations on name
    var fullNameBtnDisable: Bool {
        !self.firstNameValid.isEmpty || !self.lastNameValid.isEmpty || self.userAuthData.user.firstName.isEmpty || self.userAuthData.user.lastName.isEmpty
    }
    
    // MARK: variable to check for validation on number
    var phnNumBtnDisable: Bool {
        !self.phoneNumValid.isEmpty || self.phoneNum.isEmpty
    }
    
    // MARK: variable to check for validations on DOB
    var dobBtnDisable: Bool {
        self.userAuthData.user.dob.isEmpty
    }
    
    // MARK: variable to check for validations on gender
    var genderBtnDisable: Bool {
        self.userAuthData.user.title.isEmpty
    }
    
    // MARK: function to get dictionary based on method selected
    func getData(method: ApiMethods) -> [String: Any]? {
        switch method {
        case .signUp, .signIn : return ["user": ["email": userAuthData.user.email, "password": userAuthData.user.password, "first_name": userAuthData.user.firstName, "last_name": userAuthData.user.lastName, "dob": userAuthData.user.dob, "title": userAuthData.user.title]]
        case .profileUpdate: return ["user": ["email": updatingUserArray[4].textField, "first_name": updatingUserArray[0].textField, "last_name": updatingUserArray[1].textField, "dob": updatingUserArray[3].textField, "title": updatingUserArray[2].textField, "phone_number": updatingUserArray[5].textField]]
        case .bioUpdate: return ["user": ["email": userData?.status.data?.email, "first_name": userData?.status.data?.first_name, "last_name": userData?.status.data?.last_name, "dob": userData?.status.data?.dob, "title": userData?.status.data?.title, "phone_number": userData?.status.data?.phone_number, "bio": updateBio]]
        case .addImage: return [:]
        case .getDetails: return [:]
        case .changePassword: return ["current_password": changePassword.current_password, "password": changePassword.password, "password_confirmation": changePassword.password_confirmation]
        case .forgotPassEmail: return ["email": forgotPassEmail]
        case .resetPassword: return ["email": forgotPassEmail, "password": changePassword.password,
                                     "password_confirmation": changePassword.password_confirmation]
        default: return [:]
        }
    }
    
    // MARK: function to get url based on different methods
    func toGetURL(method: ApiMethods) -> String{
        switch method {
        case .signIn: return Constants.Url.baseURL + Constants.Url.signinKey
        case .signUp: return Constants.Url.baseURL + Constants.Url.signupKey
        case .signOut: return Constants.Url.baseURL + Constants.Url.signoutKey
        case .emailCheck: return Constants.Url.baseURL + Constants.Url.emailCheck + self.userAuthData.user.email.lowercased()
        case .profileUpdate: return Constants.Url.baseURL + Constants.Url.detailsKey
        case .bioUpdate: return Constants.Url.baseURL + Constants.Url.detailsKey
        case .addImage: return Constants.Url.baseURL + Constants.Url.addImage
        case .getDetails:
            let url = Constants.Url.baseURL + Constants.Url.getDetails + "\(self.userId)"
            return url
        case .changePassword: return Constants.Url.baseURL + Constants.Url.updatePass
        case .forgotPassEmail: return Constants.Url.baseURL + Constants.Url.sendOtp
        case .otp: return Constants.Url.baseURL + Constants.Url.verifyOtp
        case .resetPassword: return Constants.Url.baseURL + Constants.Url.resetPassword
        }
    }
    
    // MARK: computed properties
    var userData: UserResponse? {
        // get session authorization token from user defaults
        guard let data = UserDefaults.standard.value(forKey: Constants.UserDefaultKeys.profileData) as? Data else {
            // return false if not found
            return nil
        }

        let decoder = JSONDecoder()

        guard let resultData = try? decoder.decode(UserResponse.self, from: data) else {
            return nil
        }

        return resultData
    }
    
    
    /// function to make api call for all different api methods that have same response as UserResponse
    /// - Parameters:
    ///   - method: ApiMethods that are used for authentication and profile updation
    ///   - httpMethod: httpMethods like POST, PUT, etc.
    ///   - data: This gives dictionaries based on different apimethods
    func apiCall(method: ApiMethods, httpMethod: HttpMethod, data: [String:Any]?){
        
        let url = URL(string: toGetURL(method: method))
        //let data = getData(method: method)
        self.isLoading = true
        self.updateProfileDone = false
        
        anyCancellable = ApiManager.shared.apiAuthMethod(httpMethod: httpMethod, method: method, dataModel: data, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .failure(let error as ErrorResponse):
                    self.isLoading = false
                    self.hasResponseError = true
                    if error.status?.error != nil {
                        self.errorMessage1 = error.status?.error ?? ""
                    } else if error.status?.message != nil {
                        self.errorMessage1 = error.status?.message ?? ""
                    }
                    
                case .failure(let error):
                    self.isLoading = false
                    print(error)
                    self.hasError = true
                    self.errorMessage = error as? AuthenticateError
                    
                case .finished:
                    self.isLoading = false
                    self.updateProfileDone = true
                    switch method {
                    case .signUp:
                        NavigationViewModel.navigationVM.paths = [.TabBarPage]
                        UserDefaults.standard.set(self.userAuthData.user.password, forKey: Constants.UserDefaultKeys.password)
                    case .signIn:
                        NavigationViewModel.navigationVM.paths = [.TabBarPage]
                        UserDefaults.standard.set(self.userAuthData.user.password, forKey: Constants.UserDefaultKeys.password)

                    case .signOut:
                        UserDefaults.standard.set("", forKey: Constants.UserDefaultKeys.session)
                        NavigationViewModel.navigationVM.paths = []
                    case .emailCheck:
                        self.signUpViews = .fullNameView
                    case .bioUpdate:
                        print("done")
                        self.updateProfileDone = true
                    case .changePassword:
                        UserDefaults.standard.set(self.changePassword.password, forKey: Constants.UserDefaultKeys.password)
                        self.toShowChangePassword = false
                    
                    default: break
                    }
                }
                
            } receiveValue: { [weak self] data in
                self?.userResponse = data ?? UserResponse.initializeData
                print(self?.userResponse as Any)
            }

    }
    
    /// function to make api call for all different api methods that have same response as UserResponse
    /// - Parameters:
    ///   - method: ApiMethods that are used for authentication and profile updation
    ///   - httpMethod: httpMethods like POST, PUT, etc.
    ///   - data: This gives dictionaries based on different apimethods
    func forgotPassApiCall(method: ApiMethods, httpMethod: HttpMethod, data: [String:Any]?){
        
        let url = URL(string: toGetURL(method: method))
        //let data = getData(method: method)
        self.isLoading = true
        
        anyCancellable = ApiManager.shared.apiAuthMethod(httpMethod: httpMethod, method: method, dataModel: data, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .failure(let error as ForgotPasswordResponse):
                    self.isLoading = false
                    self.hasResponseError = true
                    if error.error != nil {
                        self.errorMessage1 = error.error ?? ""
                    }
                    
                case .failure(let error):
                    self.isLoading = false
                    print(error)
                    self.hasError = true
                    self.errorMessage = error as? AuthenticateError
                    
                case .finished:
                    self.isLoading = false
                    self.updateProfileDone = true
                    switch method {
                    case .forgotPassEmail:
                        self.forgotPasswordView = .otp
                        self.typeOfOtp = .forgotPassword
                    case .otp:
                        self.forgotPasswordView = .resetPassword
                    case .resetPassword:
                        NavigationViewModel.navigationVM.paths = [.OnboardingView]
                    default: break
                    }
                }
                
            } receiveValue: { [weak self] data in
                self?.forgotPasswordResponse = data ?? ForgotPasswordResponse.initialize
                print(self?.forgotPasswordResponse as Any)
            }

    }


    /// function to GET profile details
    /// - Parameters:
    ///   - method: ApiMethods
    ///   - httpMethod: HttpMethod
    ///   - data: for dictionaries
    func getProfileApiCall(method: ApiMethods, httpMethod: HttpMethod, data: [String:Any]?){
        
        let url = URL(string: toGetURL(method: method))
        //let data = getData(method: method)
        self.isLoading = true
        self.updateProfileDone = false
        
        anyCancellable1 = ApiManager.shared.apiAuthMethod(httpMethod: httpMethod, method: method, dataModel: data, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .failure(let error as ErrorResponse):
                    self.isLoading = false
                    print(error)
                    self.hasResponseError = true
                    self.errorMessage1 = error.status?.error ?? ""
                    
                case .failure(let error):
                    self.isLoading = false
                    print(error)
                    self.hasError = true
                    self.errorMessage = error as? AuthenticateError
                    
                case .finished:
                    self.isLoading = false
                    self.updateProfileDone = true
                }
                
            } receiveValue: { [weak self] data in
                self?.profileResponse = data ?? ProfileDetails.initializeData
            }

    }
    // MARK: function to validate password
    func toValidatePassword(value: String){
    
        if value.count < 8 || value.count > 16 {
            self.passValid = Constants.ValidationsMsg.passNotInRange
            
        } else if !value.isUppercase(){
            self.passValid = Constants.ValidationsMsg.uppercase
            
        } else if !value.isLowercase(){
            self.passValid = Constants.ValidationsMsg.lowercase
            
        } else if !value.containsCharacters(){
            self.passValid = Constants.ValidationsMsg.specialCh
            
        } else {
            self.passValid = ""
        }
       
    }
    
    // MARK: function to validate name
    func toValidateName() {
        if self.userAuthData.user.firstName.containsNoAlphabet() {
            self.firstNameValid = Constants.ValidationsMsg.onlyAlphabets
        } else if self.userAuthData.user.lastName.containsNoAlphabet() {
            self.lastNameValid = Constants.ValidationsMsg.onlyAlphabets
        } else {
            self.firstNameValid = ""
            self.lastNameValid = ""
        }
    }
    
    // MARK: function to validate profile name
    func toValidateProfileFields() {
        if self.updatingUserArray[0].textField.containsNoAlphabet() {
            self.nameValid = Constants.ValidationsMsg.onlyAlphabets
        } else if self.updatingUserArray[1].textField.containsNoAlphabet() {
            self.nameValid = Constants.ValidationsMsg.onlyAlphabets
        } else if self.updatingUserArray[5].textField.containsNoNumbers(){
            self.nameValid = Constants.ValidationsMsg.digitOnly
        } else if self.updatingUserArray[5].textField.count > 0 && self.updatingUserArray[5].textField.count != 10{
            self.nameValid = Constants.ValidationsMsg.max10Digit
        } else {
            self.nameValid = ""
        }
    }
    
    // MARK: function to validate phone number
    func toValidatePhoneNum() {
        if self.phoneNum.containsNoNumbers(){
            self.phoneNumValid = Constants.ValidationsMsg.digitOnly
        } else if self.phoneNum.count > 0 && self.phoneNum.count != 10 {
            self.phoneNumValid = Constants.ValidationsMsg.max10Digit
        } else {
            self.phoneNumValid = ""
        }
    }
    
    // MARK: function to validate email
    func toValidateEmail() {
        if !self.userAuthData.user.email.isValidEmail() {
            self.emailValid = Constants.ValidationsMsg.invalidEmpty
        } else {
            self.emailValid = ""
        }
    }
    
    func toValidateSamePass(){
        if self.changePassword.password != self.changePassword.password_confirmation {
            self.confirmPass = Constants.ValidationsMsg.passSame
        } else {
            self.confirmPass = ""
        }
    }
}
