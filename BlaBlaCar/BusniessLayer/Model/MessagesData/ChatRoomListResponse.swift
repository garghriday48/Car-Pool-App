//
//  ChatRoomListResponse.swift
//  BlaBlaCar
//
//  Created by Pragath on 09/08/23.
//

import Foundation


// MARK: - Welcome
struct ChatRoomListResponse: Codable {
    let code: Int
    let chats: [ChatsList]
}

// MARK: - Chat
struct ChatsList: Codable {
    let id, receiverID, senderID, publishID: Int
    let publish: GetPublishResponse?
    let receiver, sender: DataResponse
    let receiverImage, senderImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case receiverID = "receiver_id"
        case senderID = "sender_id"
        case publishID = "publish_id"
        case publish, receiver, sender
        case receiverImage = "receiver_image"
        case senderImage = "sender_image"
    }
}

struct ChatRoomWithIdResponse: Codable {
    let code: Int
    let chat: ChatsList
}

extension ChatRoomListResponse {
    static var initialize = ChatRoomListResponse(code: 0, chats: [ChatsList.initialize])
}

extension ChatsList {
    static var initialize = ChatsList(id: 0, receiverID: 0, senderID: 0, publishID: 0, publish: GetPublishResponse.initialize, receiver: DataResponse.initialize, sender: DataResponse.initialize, receiverImage: "", senderImage: "")
}

extension ChatRoomWithIdResponse {
    static var initialize = ChatRoomWithIdResponse(code: 0, chat: ChatsList.initialize)
}
