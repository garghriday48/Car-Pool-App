//
//  MessagesListResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 03/07/23.
//

import Foundation

// MARK: - MessagesListResponse
struct MessagesListResponse: Codable {
    let code: Int
    let messages: [SingleMessageResponse]
}



// MARK: - MessageListData
struct SingleMessageResponse: Codable, Hashable {
    let id: Int
    let content: String
    let senderID, receiverID: Int
    let createdAt, updatedAt: String
    let chatID: Int

    enum CodingKeys: String, CodingKey {
        case id, content
        case senderID = "sender_id"
        case receiverID = "receiver_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case chatID = "chat_id"
    }
}

extension MessagesListResponse {
    static var initialize = MessagesListResponse(code: 0, messages: [SingleMessageResponse(id: 0, content: "", senderID: 0, receiverID: 0, createdAt: "", updatedAt: "", chatID: 0)])
}

extension SingleMessageResponse {
    static var initialize = SingleMessageResponse(id: 0, content: "", senderID: 0, receiverID: 0, createdAt: "", updatedAt: "", chatID: 0)
}

