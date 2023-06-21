//
//  APIService.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import Foundation
import Combine

class ApiManager {
    
    static var shared = ApiManager()
    
    private var authToken: String?
    
    private init(){}
    

    
    func apiAuthMethod<T: Codable>(httpMethod: HttpMethod, method: ApiMethods, dataModel: [String: Any]?, url: URL?) -> AnyPublisher<T, Error> {
        //let boundary = Constants.APIConstants.boundary
        guard let dataModel = dataModel else {
            return Fail(error: AuthenticateError.badConversion).eraseToAnyPublisher()
        }
        
        guard let request = ServiceHelper.shared.setUpApiRequest(
            url: url, data: dataModel, method: method, httpMethod: httpMethod)
         else {
            // return error if request is nil
            return Fail(error: AuthenticateError.badURL).eraseToAnyPublisher()
        }

        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { _ -> AuthenticateError in return AuthenticateError.unknown }
        
            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
                
                guard let response = response as? HTTPURLResponse else { throw AuthenticateError.badResponse }
                
                if !((200..<299) ~= response.statusCode) {
                    if method == .forgotPassEmail || method == .resetPassword || method == .otp {
                        throw try JSONDecoder().decode(ForgotPasswordResponse.self, from: data)
                    }
                    throw try JSONDecoder().decode(ErrorResponse.self, from: data)
                }
                print(response)
                // if sign out it attempted
                // the clear the user defaults
                // by setting the authoriztion value of
                // SessionAuthToken to empty ""
                if method.self == .signOut { UserDefaults.standard.set("", forKey: Constants.UserDefaultKeys.session) }
                // else get the bearer token from the reponse and
                // set the user default for SessionAuthToken
                else if method.self == .signUp || method.self == .signIn {
                    // get token from response header
                    let bearer = response.value(forHTTPHeaderField: Constants.APIConstants.authorization)
                    if let bearer {
                        // store in user defaults
                        UserDefaults.standard.set(bearer, forKey: Constants.UserDefaultKeys.session)
                    }
                }

                // return data and response
                return (data, response)
                
            }
            .map(\.data)
        
            .tryMap { data in
                let decoder = JSONDecoder()
                do {
                    // if request type is of email check
                    // do not decode with SignInLogInModel directly
                    // set it up manually
                    // to avoid decoding error on. we need to avoid it
                    // because the api returns success with empty body
                    // which cannot be decoded thus check with data.count
                    // which gives the value of data
                    switch method {
                    case .emailCheck:
                        // set the status instance
                        let status = UserStatus(code: data.count, message: nil, error: nil, errors: nil, data: nil, imageUrl: nil)
                        // return signinlogin model with status instance
                        
                        return (UserResponse(status: status) as? T)!
                            
                    case .signOut:
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // set the status instance
                            let status = UserStatus(code: json["status"] as? Int ?? 0, message: json["message"] as? String, error: nil, errors: nil, data: nil, imageUrl: nil)
                            // return signinlogin model with status instance
                            return (UserResponse(status: status) as? T)!
                        }
                    case .signUp, .profileUpdate, .signIn, .bioUpdate:
                        UserDefaults.standard.set(data, forKey: Constants.UserDefaultKeys.profileData)
                    default: break
                    }

                    return try decoder.decode(T.self, from: data)
                } catch { throw AuthenticateError.noData }
            } .eraseToAnyPublisher()
    }
    
    func apiMethodsWithDict<T: Decodable, E: RawRepresentable>(httpMethod: HttpMethod, method: E, dataModel: [String:Any]?, url: URL?) -> AnyPublisher <T, Error>  where E.RawValue == String {
        
        guard let dataModel = dataModel else {
            return Fail(error: AuthenticateError.badConversion)
            .eraseToAnyPublisher()
        }
        
        guard let request = ServiceHelper.shared.setUpApiRequest(
            url: url,
            data: dataModel,
            method: method,
            httpMethod: httpMethod)
         else {
            // return error if request is nil
            return Fail(error: AuthenticateError.badURL)
                .eraseToAnyPublisher()
        }
        print(url as Any)
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { _ -> AuthenticateError in
                return AuthenticateError.unknown
            }
            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
                
                guard let response = response as? HTTPURLResponse else {
                    throw AuthenticateError.badResponse
                }
                print(response)
                
                if !((200..<299) ~= response.statusCode) {
                    throw try JSONDecoder().decode(ErrorResponse.self, from: data)
                }
                // return data and response
                return (data, response)
            }
            .map(\.data)
        
            .tryMap { data in
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw AuthenticateError.noData
                }
            }
            .eraseToAnyPublisher()

    }
    

    
    func apiRidesMethod<T: Decodable, M: Codable, E: RawRepresentable>(httpMethod: HttpMethod, method: E, dataModel: M, url: URL?) -> AnyPublisher <T, Error> where E.RawValue == String {
            guard let request = ServiceHelper.shared.setUpApiRequestWithStruct(
                url: url,
                data: dataModel,
                method: method,
                httpMethod: httpMethod)
            else {
                // return error if request is nil
                return Fail(error: AuthenticateError.badURL)
                    .eraseToAnyPublisher()
            }
            print(url as Any)
            return URLSession.shared.dataTaskPublisher(for: request)
        
            .mapError { _ -> AuthenticateError in
                return AuthenticateError.unknown
            }
            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
                
                guard let response = response as? HTTPURLResponse else {
                    throw AuthenticateError.badResponse
                }
                
                if !((200..<299) ~= response.statusCode) {
                    //throw AuthenticateError.parsing
                    if dataModel is BookRideData {
                        if response.statusCode == 422 {
                            throw AuthenticateError.alreadyBooked
                        } else {
                            throw AuthenticateError.badResponse
                        }
                    } else {
                        throw AuthenticateError.badResponse
                    }
                }
                print(response.statusCode)
                return (data, response)
                
            }
            .map(\.data)
        
            .tryMap { data in
                let decoder = JSONDecoder()
                do {
                    
                    print(data)
                    return try decoder.decode(T.self, from: data)
                    
                } catch {
                    throw AuthenticateError.noData
                }
            }
            .eraseToAnyPublisher()

    }
    
    
}
