//
//  ChatRoomView.swift
//  BlaBlaCar
//
//  Created by Pragath on 28/06/23.
//

import SwiftUI

struct ChatRoomView: View {
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @EnvironmentObject var messageVM: MessagesViewModel
    
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            ZStack{
                VStack{
                    HStack {
                        BackButton(image: Constants.Images.backArrow, action: {
                            self.dismiss()
                            messageVM.message = ""
                        }, color: .white)
                        .font(.title3)
                        .padding(.trailing)
                        
                        ImageView(size: 60,
                                  imageName: (messageVM.isSender ? messageVM.chatRoomWithIdResponse.chat.receiverImage : messageVM.chatRoomWithIdResponse.chat.senderImage),
                                  condition: (messageVM.isSender ? messageVM.chatRoomWithIdResponse.chat.receiverImage : messageVM.chatRoomWithIdResponse.chat.senderImage) == nil)
                        

                        VStack(alignment: .leading, spacing: 4){
                            Text((messageVM.isSender ? messageVM.chatRoomWithIdResponse.chat.receiver.first_name : messageVM.chatRoomWithIdResponse.chat.sender.first_name) + " " + (messageVM.isSender ? messageVM.chatRoomWithIdResponse.chat.receiver.last_name : messageVM.chatRoomWithIdResponse.chat.sender.last_name))
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                            Text(messageVM.chatRoomWithIdResponse.chat.publish?.userID == messageVM.senderId ? "Passenger" : "Driver")
//                                Text("\(Age.shared.calcAge(birthday: messageVM.chatRoomWithIdResponse.chat.sender.dob)) y/o")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            VStack(alignment: .leading, spacing: 7){
                HStack{
                    Text(messageVM.chatRoomWithIdResponse.chat.publish?.source ?? "")
                        
                    Image(systemName: Constants.Images.bigRightArrow)
                    Text(messageVM.chatRoomWithIdResponse.chat.publish?.destination ?? "")
                        
                }
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                
                
                if let sourceTime = messageVM.chatRoomWithIdResponse.chat.publish?.time, let sourceDate = messageVM.chatRoomWithIdResponse.chat.publish?.date {
                    Text("\(DateTimeFormat.shared.dateFormat(date: sourceDate)), \(DateTimeFormat.shared.timeFormat(date: sourceTime, is24hrs: false, toNotReduce: false))")
                }
            }
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal)
            
            VStack{
                ScrollViewReader { scroll in
                    ScrollView {
                        
                        ForEach(0..<(messageVM.dateWiseMessagesList?.count ?? 0), id: \.self){index in
                            VStack{
                                Text(DateTimeFormat.shared.dateFormat(date: messageVM.dateWiseMessagesList?[index].key ?? "")).font(.system(size: 16, weight: .bold ,design: .rounded)).padding(.top)
                                
                                ForEach(messageVM.dateWiseMessagesList?[index].value ?? [], id: \.id){message in
                                    
                                    ChatBubble(message: message, messageDirection: message.receiverID == messageVM.senderId ? .left : .right)
                                    
                                }
                                .onAppear{
                                    scroll.scrollTo(messageVM.lastMsg)
                                }
                                .onChange(of: messageVM.lastMsg) { msg in
                                    withAnimation {
                                        scroll.scrollTo(msg)
                                    }
                                }
                            }
                            
                        }
                        .refreshable {
                            messageVM.messageListApiCall(method: .messageList, httpMethod: .GET)
                        }
                    }
                    .onChange(of: messageVM.keyboardHeight) { _ in
                        scroll.scrollTo(messageVM.lastMsg)
                    }

                }
                
                HStack{
                    HStack(spacing: 15) {
                        TextField("Message", text: $messageVM.message)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(.black.opacity(0.06))
                    .clipShape(Capsule())
                    .autocorrectionDisabled()
                    
                    /// Send button
                    /// Only to be shown when message is not empty
                    if messageVM.message != "" {
                        Button {
                            messageVM.MessageApiCall(method: .message, httpMethod: .POST, data: MessageData(message: SingleMessageData(content: messageVM.message, receiver_id: messageVM.isSender ? messageVM.chatRoomWithIdResponse.chat.receiverID : messageVM.chatRoomWithIdResponse.chat.senderID)))
                            
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color(Color.redColor))
                                .rotationEffect(.init(degrees: 45))
                                .padding([.vertical, .leading], 12)
                                .padding(.trailing, 17)
                                .background(.black.opacity(0.07))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal, 10)
                .animation(.easeInOut, value: messageVM.message)
                .animation(.easeInOut, value: messageVM.keyboardHeight)
                .padding(.bottom, messageVM.keyboardHeight == 0 ? 0 : messageVM.keyboardHeight - 10)
            }
            .padding(.bottom, messageVM.keyboardHeight == 0 ? 25 : 0)
            .background(.white)
            .clipShape(RoundedShape())
        }
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(Color.redColor).opacity(0.9))
        .environmentObject(messageVM)
    }
}

struct ChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomView()
            .environmentObject(MyRidesViewModel())
            .environmentObject(MessagesViewModel())
            //.environmentObject(MessagesViewModel())
    }
}
