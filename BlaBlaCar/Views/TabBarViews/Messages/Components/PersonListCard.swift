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
    
    var array = Passengers(userID: 0, firstName: "Hriday", lastName: "Garg", dob: "2001-12-06", phoneNumber: "", phoneVerified: false, image: "", averageRating: "", bio: "", travelPreferences: "", seats: 2)
    
    var body: some View {
        VStack{
            HStack {
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
                                Color.gray.opacity(0.1)
                                ProgressView()
                            }
                        }
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(lineWidth: 1)
                    }
                    .padding(.leading)
                    VStack(alignment: .leading, spacing: 4){
                        Text("Hriday" + " " + "Garg")
                            .foregroundColor(.black)
                            .font(.title3)
                        
                        VStack(alignment: .leading, spacing: 7){
                            HStack{
                                Text(myRidesVM.publishResponseWithId.data.source)
                                
                                Image(systemName: Constants.Images.bigRightArrow)
                                Text(myRidesVM.publishResponseWithId.data.destination)
                            }
                            .frame(maxWidth: 300)
                            .lineLimit(2)
                            if let sourceTime = myRidesVM.publishResponseWithId.data.time {
                                Text("\(DateTimeFormat.shared.dateFormat(date: myRidesVM.publishResponseWithId.data.date)), \(DateTimeFormat.shared.timeFormat(date: sourceTime, is24hrs: false, toNotReduce: false))")
                            }
                        }
                        .font(.system(size: 12))
                        .foregroundColor(Color(.darkGray))
                    }
                    .padding(.horizontal, 10)
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            DividerCapsule(height: 2, color: Color(.systemGray3))
        }
    }
}

struct PersonListCard_Previews: PreviewProvider {
    static var previews: some View {
        PersonListCard()
            .environmentObject(MyRidesViewModel())
            .environmentObject(MessagesViewModel())
    }
}
