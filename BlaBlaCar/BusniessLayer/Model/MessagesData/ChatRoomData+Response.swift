//
//  ChatRoomData+Response.swift
//  BlaBlaCar
//
//  Created by Pragath on 09/08/23.
//

import Foundation


// MARK: Data - ChatRoomData
struct ChatRoomData: Codable {
    let chat: ChatData
}

// MARK: - Chat
struct ChatData: Codable {
    let receiverID, publishID: Int

    enum CodingKeys: String, CodingKey {
        case receiverID = "receiver_id"
        case publishID = "publish_id"
    }
}


// MARK: Response - ChatRoomResponse
struct ChatRoomResponse: Codable, Error {
    let code: Int
    let error: String?
    let chat: ChatResponse
}

// MARK: - Chat
struct ChatResponse: Codable {
    let id, senderID, receiverID: Int
    let createdAt, updatedAt: String
    let publishID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case senderID = "sender_id"
        case receiverID = "receiver_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case publishID = "publish_id"
    }
}

extension ChatRoomResponse {
    static var initialize = ChatRoomResponse(code: 0, error: nil, chat: ChatResponse(id: 0, senderID: 0, receiverID: 0, createdAt: "", updatedAt: "", publishID: 0))
}

extension ChatRoomData {
    static var initialize = ChatRoomData(chat: ChatData(receiverID: 0, publishID:0))
}

