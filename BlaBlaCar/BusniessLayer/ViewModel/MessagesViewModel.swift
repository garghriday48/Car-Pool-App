//
//  MessagesViewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 28/06/23.
//

import Foundation
import Combine

class MessagesViewModel: ObservableObject {
    
    
    @Published var messagesListResponse = MessagesListResponse.initialize
    @Published var messageData = MessageData.initialize
    @Published var messageDataResponse = MessageDataResponse.initialize
    @Published var dateWiseMessagesList: [String:[SingleMessageResponse]] = [:]
    
    @Published var lastMsg = 0
    
    private var empty = Empty()
    private var anyCancellable: AnyCancellable?
    private var anyCancellable1: AnyCancellable?
    
    
    /// Function to convert MessageListReposne into a dictionary with dates as keys
    /// - Parameter data: MessageListResponse
    /// - Returns: A dictionary with dates as keys and values as array of MessageData struct
    func datewiseMessageList(data: MessagesListResponse) -> [String: [SingleMessageResponse]]{
        var resultData: [String: [SingleMessageResponse]] = [:]
        
        for i in data.messages.reversed() {
            let date = DateTimeFormat.shared.dateFromApiFormat(date: i.createdAt)
            
            if resultData[date] == nil {
                self.lastMsg = 1
                resultData[date] = [i]
            } else {
                self.lastMsg += 1
                resultData[date]?.append(i)
                
            }
        }
        return resultData
    }
    
    
    /// function to get url based on different methods
    func toGetURL(method: ApiMessagingMethods) -> String{
        switch method {
        case .messageList, .message:
            return Constants.Url.baseURL + Constants.Url.messageList
        }
    }
        
    /// function to call API that are related to bookRideData
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func MessageListApiCall(method: ApiMessagingMethods, httpMethod: HttpMethod){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: empty, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error as ErrorResponse):
                    if error.error == "Chat already exists" {
                        
                    } else {
                        ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    }
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    self.dateWiseMessagesList = self.datewiseMessageList(data: self.messagesListResponse)
                    print(self.dateWiseMessagesList as Any)
                }
                
            } receiveValue: { [weak self] data in
                self?.messagesListResponse = data ?? MessagesListResponse.initialize
                print(self?.messagesListResponse as Any)
                
                
            }
        
    }
    
    /// function to call API that are related to bookRideData
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func MessageApiCall(method: ApiMessagingMethods, httpMethod: HttpMethod, data: MessageData){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: data, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error as ErrorResponse):
                    if error.error == "Chat already exists" {
                        
                    } else {
                        ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    }
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    self.MessageListApiCall(method: .messageList, httpMethod: .GET)
                }
                
            } receiveValue: { [weak self] data in
                self?.messageDataResponse = data ?? MessageDataResponse.initialize
                print(self?.messageDataResponse as Any)
                
                
            }
        
    }
}
