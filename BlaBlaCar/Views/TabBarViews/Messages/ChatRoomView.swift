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
    
    //var chatData: ChatsList
    

    //@State var message = ""
    
    
    var body: some View {
        VStack{
            ZStack{
                VStack{
                    HStack {
                        BackButton(image: Constants.Images.backArrow) {
                            self.dismiss()
                        }
                        .font(.title2)
                        .padding(.trailing)
                        
                        ImageView(size: 60,
                                  imageName: (messageVM.isSender ? messageVM.chatRoomWithIdResponse.chat.receiverImage : messageVM.chatRoomWithIdResponse.chat.senderImage),
                                  condition: (messageVM.isSender ? messageVM.chatRoomWithIdResponse.chat.receiverImage : messageVM.chatRoomWithIdResponse.chat.senderImage) == nil)
                        

                        VStack(alignment: .leading, spacing: 4){
                            Text((messageVM.isSender ? messageVM.chatRoomWithIdResponse.chat.receiver.first_name : messageVM.chatRoomWithIdResponse.chat.sender.first_name) + " " + (messageVM.isSender ? messageVM.chatRoomWithIdResponse.chat.receiver.last_name : messageVM.chatRoomWithIdResponse.chat.sender.last_name))
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                Text("\(Age.shared.calcAge(birthday: messageVM.chatRoomWithIdResponse.chat.sender.dob)) y/o")
                                    .font(.system(size: 14, design: .rounded))
                                    .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        
                    } label: {
                        HStack{
                            Text("Ride Details")
                            Image(systemName: Constants.Images.bigRightArrow)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                    }
                    .padding()
                }
            }
            
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
//            .onAppear{
//                if messageVM.senderId == chatData.senderID {
//                    messageVM.isSender = true
//                } else {
//                    messageVM.isSender = false
//                }
//            }
        
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
            //.environmentObject(MessagesViewModel())
    }
}
