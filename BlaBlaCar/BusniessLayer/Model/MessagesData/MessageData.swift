//
//  MessageData.swift
//  BlaBlaCar
//
//  Created by Pragath on 07/07/23.
//

import Foundation


// MARK: MessageData
struct MessageData: Codable {
    var message: SingleMessageData
}

struct SingleMessageData: Codable {
    var content: String
    var receiver_id: Int
}


struct MessageDataResponse: Codable {
    let code: Int
    var message: SingleMessageResponse
}



extension MessageData {
    static var initialize = MessageData(message: SingleMessageData(content: "", receiver_id: 0))
}


extension MessageDataResponse {
    static var initialize = MessageDataResponse(code:  0, message: SingleMessageResponse.initialize)
}
