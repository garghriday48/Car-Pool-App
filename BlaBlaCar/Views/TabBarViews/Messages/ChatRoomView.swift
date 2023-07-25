//
//  ChatRoomView.swift
//  BlaBlaCar
//
//  Created by Pragath on 28/06/23.
//

import SwiftUI

struct ChatRoomView: View {
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @StateObject var messageVM = MessagesViewModel()
    
    @Environment (\.dismiss) var dismiss
    
    var array = Passengers(userID: 0, firstName: "Hriday", lastName: "Garg", dob: "2001-12-06", phoneNumber: "", phoneVerified: false, image: "", averageRating: "", bio: "", travelPreferences: "", seats: 2)
    

    @State var message = ""
    @State var newArray: [String] = []
    
    
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
                        
                        if let image = array.image {
                            AsyncImage(url: URL(string: image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                if array.image == nil {
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
                                Circle().stroke(.white ,lineWidth: 1)
                            }
                            VStack(alignment: .leading, spacing: 4){
                                Text(array.firstName + " " + array.lastName)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                Text("\(Age.shared.calcAge(birthday: array.dob)) y/o")
                                    .font(.system(size: 14, design: .rounded))
                                    .foregroundColor(.white)
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
                        .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            
            ScrollViewReader { scroll in
                VStack{
                    ScrollView {
                        
                        
                        ForEach(newArray ,id: \.self){date in
                            VStack{
                                Text(date).font(.system(size: 16, weight: .bold ,design: .rounded)).padding(.top)
                                ForEach(messageVM.dateWiseMessagesList[date] ?? [], id: \.id){message in
                                    
                                    //messageVM.messageDirection = .right
                                    ChatBubble(message: message, messageDirection: message.senderID == 279 ? .left : .right)
                                    
                                }
                            }
                            
                        }
                    }
                    
                    
                    HStack{
                        HStack(spacing: 15) {
                            TextField("Message", text: $message)
                            
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
                        if self.message != "" {
                            Button {
                                messageVM.MessageApiCall(method: .message, httpMethod: .POST, data: MessageData(message: SingleMessageData(content: self.message, receiver_id: 279)))
                                
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
                    .animation(.easeOut, value: self.message)
                }
                .padding(.bottom, 25)
                .background(.white)
                .clipShape(RoundedShape())
                .onAppear{
                    messageVM.MessageListApiCall(method: .messageList, httpMethod: .GET)
                    newArray = Array(messageVM.dateWiseMessagesList.keys)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
////                        scroll.scrollTo(messageVM.dateWiseMessagesList[newArray[newArray.count - 1]]?[newArray[newArray.count - 1].count - 1])
//
//                    }
                }
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
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(Color.redColor))
        .onChange(of: messageVM.dateWiseMessagesList.count, perform: { newValue in
            print(newValue)
            newArray = Array(messageVM.dateWiseMessagesList.keys)
        })
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
