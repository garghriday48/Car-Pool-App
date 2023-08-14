//
//  MessagesViewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 28/06/23.
//

import Foundation
import Combine
import UIKit

class MessagesViewModel: ObservableObject {
    
    
    @Published var messagesListResponse = MessagesListResponse.initialize
    @Published var messageData = MessageData.initialize
    @Published var messageDataResponse = MessageDataResponse.initialize
    @Published var dateWiseMessagesList:  [Dictionary<String, [SingleMessageResponse]>.Element]?
    
    @Published var chatRoomData = ChatRoomData.initialize
    @Published var chatRoomResponse = ChatRoomResponse.initialize
    ///@Published var singleChatRoomData = ChatsList.initialize
    
    @Published var chatRoomListResponse = ChatRoomListResponse.initialize
    @Published var chatRoomWithIdResponse = ChatRoomWithIdResponse.initialize
    
    @Published var numOfChatRoom = 0
    
    @Published var senderId = 0
    @Published var lastMsg = 0
    
    @Published var message = ""
    
    @Published var toChatRoom = false
    @Published var chatRoomId = 0
    
    @Published var toChatRoomFromRides = false
    //@Published var chatRoomIdFromRides = 0
    //@Published var newMessageArray: [String] = []
    @Published var isSender = false
    
    @Published var keyboardHeight: CGFloat = 0
    
    private var empty = Empty()
    private var anyCancellable: AnyCancellable?
    private var anyCancellable1: AnyCancellable?
    private var anyCancellable2: AnyCancellable?
    
    
    init(){
        listenForKeyboardNotifications()
    }
    
    
    /// Function to convert MessageListReposne into a dictionary with dates as keys
    /// - Parameter data: MessageListResponse
    /// - Returns: A dictionary with dates as keys and values as array of MessageData struct
    func datewiseMessageList(data: MessagesListResponse){
        var resultData: [String: [SingleMessageResponse]] = [:]
        
        for i in data.messages.reversed() {
            let date = DateTimeFormat.shared.dateFromApiFormat(date: i.createdAt)
            
            if resultData[date] == nil {
                resultData[date] = [i]
            } else {
                
                resultData[date]?.append(i)
                
            }
        }
        let sorted = resultData.sorted(by: { $0.key < $1.key })

        self.dateWiseMessagesList = sorted
    }
    
    
    /// function to get url based on different methods
    func toGetURL(method: ApiMessagingMethods) -> String{
        switch method {
        case .chatRoom, .chatRoomList:
            return Constants.Url.baseURL + Constants.Url.chatRoom
        case .messageList, .message:
            return Constants.Url.baseURL + Constants.Url.messageList + "\(chatRoomId)" + Constants.Url.messages
        case .singleChatRoom:
            return Constants.Url.baseURL + Constants.Url.chatRoom + "/\(chatRoomId)"
        }
    }
    
    
    /// function to call API that is used to get all the messages that are done in a particular chat room.
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func chatRoomApiCall(method: ApiMessagingMethods, httpMethod: HttpMethod, model: ChatRoomData){
        
        let url = URL(string: toGetURL(method: method))
        ResponseErrorViewModel.shared.isLoading = true
        
        anyCancellable = ApiManager.shared.apiMethodWithStruct(httpMethod: httpMethod, method: method, dataModel: model, url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error as ErrorResponse):
                    if error.error == "Chat already exists" {
                        self.getData(data: error)
                        
                        self.chatRoomWithIdApiCall(method: .singleChatRoom, httpMethod: .GET)
                    } else {
                        ResponseErrorViewModel.shared.toShowResponseError(error: error)
                    }
                    
                case .failure(let error):
                    ResponseErrorViewModel.shared.toShowError(error: error)
                    
                case .finished:
                    ResponseErrorViewModel.shared.isLoading = false
                    self.chatRoomId = self.chatRoomResponse.chat.id
                    self.chatRoomWithIdApiCall(method: .singleChatRoom, httpMethod: .GET)
                }
                
            } receiveValue: { [weak self] data in
                self?.chatRoomResponse = data ?? ChatRoomResponse.initialize
                print(self?.chatRoomResponse as Any)
                
                
            }
        
    }
    
    func getData(data: ErrorResponse){
        if let id = data.chat?.id {
            self.chatRoomId = id
        }
    }
    
    /// function to call API that is used to get all the messages that are done in a particular chat room.
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func chatRoomListApiCall(method: ApiMessagingMethods, httpMethod: HttpMethod){
        
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
                    self.numOfChatRoom = self.chatRoomListResponse.chats.count
                }
                
            } receiveValue: { [weak self] data in
                self?.chatRoomListResponse = data ?? ChatRoomListResponse.initialize
                print(self?.chatRoomListResponse as Any)
                
                
            }
        
    }
    
    
    /// function to call API that is used to get all the messages that are done in a particular chat room.
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func chatRoomWithIdApiCall(method: ApiMessagingMethods, httpMethod: HttpMethod){
        
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
                    
                    self.toChatRoomFromRides.toggle()
                    //self.singleChatRoomData = self.chatRoomWithIdResponse.chat
                    
                    self.chatRoomId = self.chatRoomWithIdResponse.chat.id
                    self.messageListApiCall(method: .messageList, httpMethod: .GET)
                    
                    if self.senderId == self.chatRoomWithIdResponse.chat.senderID {
                        self.isSender = true
                    } else {
                        self.isSender = false
                    }
                }
                
            } receiveValue: { [weak self] data in
                self?.chatRoomWithIdResponse = data ?? ChatRoomWithIdResponse.initialize
                print(self?.chatRoomWithIdResponse as Any)
                
                
            }
        
    }
    
    
    /// function to call API that is used to get all the messages that are done in a particular chat room.
    /// - Parameters:
    ///   - method: to specify ride method for performing different functions
    ///   - httpMethod: to specify httpmethod like GET, POST, etc.
    func messageListApiCall(method: ApiMessagingMethods, httpMethod: HttpMethod){
        
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
                    self.datewiseMessageList(data: self.messagesListResponse)
                    if !self.messagesListResponse.messages.isEmpty {
                        self.lastMsg = self.messagesListResponse.messages[0].id
                    } else {self.lastMsg = 0}
                    //self.newMessageArray = Array(self.dateWiseMessagesList)
                    //print(self.dateWiseMessagesList as Any)
                }
                
            } receiveValue: { [weak self] data in
                self?.messagesListResponse = data ?? MessagesListResponse.initialize
                print(self?.messagesListResponse as Any)
                
                
            }
        
    }
    
    /// function to call API that is used to post the message send from the user to server.
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
                    self.messageListApiCall(method: .messageList, httpMethod: .GET)
                }
                
            } receiveValue: { [weak self] data in
                self?.messageDataResponse = data ?? MessageDataResponse.initialize
                self?.message = ""
                print(self?.messageDataResponse as Any)
                
                
            }
    }
        
        
    /// Function is used to get the height of keyboard based on keyboard is shown or not.
    private func listenForKeyboardNotifications() {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
               object: nil,
               queue: .main) { (notification) in
                guard let userInfo = notification.userInfo,
                    let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                
                self.keyboardHeight = keyboardRect.height
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
               object: nil,
               queue: .main) { (notification) in
                self.keyboardHeight = 0
            }
        }
        
}
