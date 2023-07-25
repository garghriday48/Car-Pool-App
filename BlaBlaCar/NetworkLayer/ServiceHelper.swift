//
//  ServiceHelper.swift
//  BlaBlaCar
//
//  Created by hriday garg on 01/06/23.
//

import Foundation
import Combine
import UIKit

class ServiceHelper {
    
    static let shared = ServiceHelper()
    
    private init() {}
    
    
    /// method to create the body of data for sending the
    /// image, and other details of user to the server
    /// used in only put request for sending the user data
    /// - Parameter params: data dictionary
    /// - Returns: body of type Data
    func createDataBody(withParameters params: [String: Any?]) -> Data {

        // initialize data object
        var body = Data()

        // constant string struct
        let dataBodyStrings = Constants.StringForDataBody.self

        // loop over params dictionary
        for (key, value) in params {

            // append boundary with a line break

            body.append(dataBodyStrings.boudaryWithLineBreakTwoHyphens)

            if let value = value {
                // check if key is for imageURL
                if key == "image" {

                    if let image = value as? UIImage {
                        body.append(String(format: dataBodyStrings.imageContentDisposition, key, "\(SignInSignUpViewModel.shared.userData?.status.data?.first_name ?? "image").png"))
                        body.append(String(format: dataBodyStrings.imageContentType, dataBodyStrings.imageMimePng))

                        if let data = image.jpegData(compressionQuality: 0.01) {
                            body.append(data)
                            body.append(dataBodyStrings.lineBreak)
                        }
                    }
                }
            }
        }

        body.append(dataBodyStrings.boudaryWithLineBreakFourHyphens)
        return body
    }
    
    
    /// method to set up api request and return it as url request
    /// - Parameters:
    ///   - endPoint: string value of api endpoint. used with base api url to form a valid url
    ///   - httpMethod: method of api request i.e. get, post, delete, put
    ///   - data: dictionary for sending some json data alog with api
    ///   - requestType: type of request i.e. signup, login, email check etc.
    /// - Returns: a url request which is used to for url session
    func setUpApiRequest<T: RawRepresentable>(url: URL?, data: [String: Any], method: T, httpMethod: HttpMethod) -> URLRequest? where T.RawValue == String {

        
        // get the url from base url string
        guard let url = url else {
            return nil
        }

        // initialize url request
        var request = URLRequest(url: url)

        // set the http method
        request.httpMethod = method.rawValue.trimmingCharacters(in: .whitespaces)

        // set the token value to request headers by fetching
        // it from user defaults
        if let tokenValue = UserDefaults.standard.string(forKey: Constants.UserDefaultKeys.session) {
            if !tokenValue.isEmpty {

                request.setValue(tokenValue, forHTTPHeaderField: Constants.APIConstants.authorization)
            }
        }

        if httpMethod != .GET {
            if method as? ApiMethods == .addImage {
                request.setValue(Constants.StringForDataBody.multipartFormData, forHTTPHeaderField: Constants.APIConstants.content_type)
            } else {
                request.setValue(Constants.APIConstants.application, forHTTPHeaderField: Constants.APIConstants.content_type)
            }
            
             //convert dictionary data to json
            let jsonData = method as? ApiMethods == .addImage
            ? createDataBody(withParameters: data)
            : try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
            //let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
            // set json data in request http body
            request.httpBody = jsonData
        }

        // return url request
        return request
    }
    
    
    /// method to set up api request and return it as url request
    /// - Parameters:
    ///   - endPoint: string value of api endpoint. used with base api url to form a valid url
    ///   - httpMethod: method of api request i.e. get, post, delete, put
    ///   - data: struct for sending some json data alog with api
    ///   - requestType: type of request i.e. signup, login, email check etc.
    /// - Returns: a url request which is used to for url session
    func setUpApiRequestWithStruct<T: RawRepresentable, M: Codable>(url: URL?, data: M, method: T, httpMethod: HttpMethod) -> URLRequest? where T.RawValue == String {

        
        // get the url from base url string
        guard let url = url else {
            return nil
        }
        
        // initialize url request
        var request = URLRequest(url: url)

        // set the http method
        request.httpMethod = method.rawValue.trimmingCharacters(in: .whitespaces)

        // set the token value to request headers by fetching
        // it from user defaults
        if let tokenValue = UserDefaults.standard.string(forKey: Constants.UserDefaultKeys.session) {
            if !tokenValue.isEmpty {

                request.setValue(tokenValue, forHTTPHeaderField: Constants.APIConstants.authorization)
            }
        }

        if httpMethod != .GET {
            // set content type
            request.setValue(Constants.APIConstants.application, forHTTPHeaderField: Constants.APIConstants.content_type)

            // convert dictionary data to json
            guard let jsonData = try? JSONEncoder().encode(data) else {
                return nil
            }
            //let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)

            // set json data in request http body
            request.httpBody = jsonData
        }

        // return url request
        return request
    }
    
    func checkResponse(response: URLResponse, data: Data) throws -> (Data, URLResponse){
        guard let response = response as? HTTPURLResponse else {
            throw AuthenticateError.badResponse
        }
        
        if !((200..<299) ~= response.statusCode) {
            throw try JSONDecoder().decode(ErrorResponse.self, from: data)
        }
        print(response)
        return (data, response)
    }
    
    func checkNetworkError(error: Error) -> AuthenticateError{
        if error.localizedDescription == Constants.APIConstants.sslError {
            return AuthenticateError.networkError
        } else if error.localizedDescription == Constants.APIConstants.wrongUrl {
            return AuthenticateError.incorrectHostname
        } else {  return AuthenticateError.unknown }
    }
    
}
