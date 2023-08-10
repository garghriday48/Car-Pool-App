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
    
    var chatData: ChatsList
    

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
                        
                        if let image = messageVM.isSender ? chatData.receiverImage : chatData.senderImage{
                            AsyncImage(url: URL(string: image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                if (messageVM.isSender ? chatData.receiverImage : chatData.senderImage) == nil {
                                    Image(Constants.Images.person)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    ZStack {
                                        Color.white.opacity(0.1)
                                        ProgressView()
                                        
                                    }
                                }
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(.black ,lineWidth: 1)
                            }
                            VStack(alignment: .leading, spacing: 4){
                                Text((messageVM.isSender ? chatData.receiver.first_name : chatData.sender.first_name) + " " + (messageVM.isSender ? chatData.receiver.last_name : chatData.sender.last_name))
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
//                                Text("\(Age.shared.calcAge(birthday: chatData.sender.dob)) y/o")
//                                    .font(.system(size: 14, design: .rounded))
//                                    .foregroundColor(.black)
                            }
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
            
            ScrollViewReader { scroll in
                VStack{
                    ScrollView {
                        
                        
                        ForEach(0..<(messageVM.dateWiseMessagesList?.count ?? 0), id: \.self){index in
                            VStack{
                                Text(DateTimeFormat.shared.dateFormat(date: messageVM.dateWiseMessagesList?[index].key ?? "")).font(.system(size: 16, weight: .bold ,design: .rounded)).padding(.top)
                                ForEach(messageVM.dateWiseMessagesList?[index].value ?? [], id: \.id){message in
                                    
                                    //messageVM.messageDirection = .right
                                    ChatBubble(message: message, messageDirection: message.receiverID == messageVM.senderId ? .left : .right)
                                    
                                }
                            }
                            
                        }
                        .refreshable {
                            messageVM.messageListApiCall(method: .messageList, httpMethod: .GET)
                        }
                    }

                    HStack{
                        HStack(spacing: 15) {
                            TextField("Message", text: $messageVM.message)
                            
                            //                        Button(action: {}) {
                            //                            Image(systemName: "paperclip.circle.fill")
                            //                                .font(.system(size: 22))
                            //                                .foregroundColor(.gray)
                            //                        }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background(.black.opacity(0.06))
                        .clipShape(Capsule())
                        
                        /// Send button
                        /// Only to be shown when message is not empty
                        if messageVM.message != "" {
                            Button {
                                messageVM.MessageApiCall(method: .message, httpMethod: .POST, data: MessageData(message: SingleMessageData(content: messageVM.message, receiver_id: messageVM.isSender ? chatData.receiverID : chatData.senderID)))
                                
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
                    .animation(.easeOut, value: messageVM.message)
                }
                .padding(.bottom, 25)
                .background(.white)
                .clipShape(RoundedShape())
                .onChange(of: messageVM.messagesListResponse.messages.count, perform: { _ in
                    //DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    scroll.scrollTo(messageVM.messagesListResponse.messages[0])
                    //}
                })
//                (of: messageVM.messagesListResponse.messages.count) { count in
//
//                        //scroll.scrollTo(messageVM.dateWiseMessagesList[newArray[newArray.count - 1]]?[messageVM.lastMsg - 1])
//                }
            }
            .onAppear{
                if messageVM.senderId == chatData.senderID {
                    messageVM.isSender = true
                } else {
                    messageVM.isSender = false
                }
            }
        }
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(Color.redColor).opacity(0.9))
        .environmentObject(messageVM)
    }
}

struct ChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomView(chatData: ChatsList.initialize)
            .environmentObject(MyRidesViewModel())
            //.environmentObject(MessagesViewModel())
    }
}
