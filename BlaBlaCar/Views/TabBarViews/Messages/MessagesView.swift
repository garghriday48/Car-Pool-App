//
//  MessagesView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct MessagesView: View {
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @EnvironmentObject var messageVM: MessagesViewModel
    
    var body: some View {
        VStack{
            Text(Constants.Headings.messages)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity ,alignment: .topLeading)
                .padding()
            
            DividerCapsule(height: 1, color: Color(.gray).opacity(0.5))
            
            List(messageVM.chatRoomListResponse.chats, id: \.id){chat in
                    Button {
                        messageVM.toChatRoom.toggle()
                        messageVM.chatRoomId = chat.id
                        //messageVM.singleChatRoomData = chat
                        messageVM.chatRoomWithIdApiCall(method: .singleChatRoom, httpMethod: .GET)
                        messageVM.messageListApiCall(method: .messageList, httpMethod: .GET)
                    } label: {
                        PersonListCard(data: chat)
                    }
                    .listRowSeparator(.hidden)

                }
            
            .listStyle(.plain)
            .refreshable {
                messageVM.chatRoomListApiCall(method: .chatRoomList, httpMethod: .GET)
            }
            
        }
        .fullScreenCover(isPresented: $messageVM.toChatRoom, content: {
            ChatRoomView()
        })
        .onAppear{
            messageVM.chatRoomListApiCall(method: .chatRoomList, httpMethod: .GET)
            
            
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
            .environmentObject(MyRidesViewModel())
            .environmentObject(MessagesViewModel())
    }
}
