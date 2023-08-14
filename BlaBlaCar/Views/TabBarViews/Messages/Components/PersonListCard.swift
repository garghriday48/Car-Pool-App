//
//  PersonListCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 28/06/23.
//

import SwiftUI

struct PersonListCard: View {
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @EnvironmentObject var messageVM: MessagesViewModel
    
    @State var isSender = false
    
    var data: ChatsList
    
    var body: some View {
        VStack{
            HStack {
//                ImageView(size: 80,
//                          imageName: (messageVM.isSender ? data.receiverImage : data.senderImage),
//                          condition: (messageVM.isSender ? data.receiverImage : data.senderImage) == nil)
                Group{
                    if let image = (self.isSender ? data.receiverImage : data.senderImage) {
                        AsyncImage(url: URL(string: image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                            
                            
                        } placeholder: {
                            if (self.isSender ? data.receiverImage : data.senderImage) == nil {
                                Image(Constants.Images.person)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                ZStack {
                                    Color.gray.opacity(0.1)
                                    ProgressView()
                                }
                            }
                        }
                    } else {
                        Image(Constants.Images.person)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(lineWidth: 1)
                }
            
                .padding(.leading)
                
                
                
                VStack(alignment: .leading, spacing: 4){
                    Text("\(self.isSender ? data.receiver.first_name : data.sender.first_name)\(" ")\(self.isSender ? data.receiver.last_name : data.sender.last_name)")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        
                    
                    VStack(alignment: .leading, spacing: 7){
                        HStack{
                            Text(data.publish?.source ?? "")
                                
                            Image(systemName: Constants.Images.bigRightArrow)
                            Text(data.publish?.destination ?? "")
                                
                        }
                        .font(.system(size: 14, weight: .none, design: .rounded))
                        .frame(maxWidth: 300, alignment: .leading)
                        .lineLimit(2)
                        if let sourceTime = data.publish?.time, let sourceDate = data.publish?.date {
                            Text("\(DateTimeFormat.shared.dateFormat(date: sourceDate)), \(DateTimeFormat.shared.timeFormat(date: sourceTime, is24hrs: false, toNotReduce: false))")
                        }
                    }
                    .font(.system(size: 12, weight: .none, design: .rounded))
                    .foregroundColor(Color(.darkGray))
                }
                .padding(.horizontal, 10)
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            DividerCapsule(height: 1, color: Color(.gray).opacity(0.5))
        }
        .onAppear{
            if messageVM.senderId == data.senderID {
                self.isSender = true
            } else {
                self.isSender = false
            }
        }
    }
}

struct PersonListCard_Previews: PreviewProvider {
    static var previews: some View {
        PersonListCard(data: ChatsList.initialize)
            .environmentObject(MyRidesViewModel())
            .environmentObject(MessagesViewModel())
    }
}
