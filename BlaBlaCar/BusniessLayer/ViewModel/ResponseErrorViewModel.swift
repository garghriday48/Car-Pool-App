//
//  ResponseErrorViewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 23/06/23.
//

import Foundation


class ResponseErrorViewModel: ObservableObject {
    
    static var shared = ResponseErrorViewModel()
    
    private init() {}
    
    // MARK: variables to check and get error so as to display an alert
    @Published var hasError      = false
    @Published var hasResponseError = false
    @Published var errorMessage  : AuthenticateError?
    @Published var errorMessage1 = String()
    
    // MARK: to show loader
    @Published var isLoading = false
    @Published var loaderLoading = false
    
    func toShowResponseError(error: ErrorResponse) {
        self.isLoading = false
        self.hasResponseError = true
        if error.status?.error != nil {
            self.errorMessage1 = error.status?.error ?? ""
        } else if error.status?.message != nil {
            self.errorMessage1 = error.status?.message ?? ""
        }
    }
    
    func toShowError(error: Error) {
        self.isLoading = false
        print(error.localizedDescription)
        self.errorMessage = error as? AuthenticateError
        self.hasError = true
    }
}
