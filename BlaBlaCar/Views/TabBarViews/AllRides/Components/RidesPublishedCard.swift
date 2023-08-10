//
//  RidesPublishedCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 13/06/23.
//

import SwiftUI

struct RidesPublishedCard: View {
    
    var array: GetPublishResponse
    
    @State var publishedType: (String, Color) = ("", Color.white)
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 7){
                HStack{
                    Group {
                        Text(array.source.capitalized)
                        Image(systemName: Constants.Images.bigRightArrow)
                        Text(array.destination.capitalized)
                            
                    }
                    .lineLimit(2)
                    .font(.system(size: 16, weight: .semibold ,design: .rounded))
                    .multilineTextAlignment(.leading)
                    
                    Spacer()
                    Text(publishedType.0).foregroundColor(publishedType.1)
                        .font(.system(size: 12, weight: .semibold ,design: .rounded))
                        .frame(width: 100, height: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .fill(publishedType.1.opacity(0.2))
                        )
                    
                }
                .foregroundColor(.black)
                VStack(spacing: 5){
                    Text("Rs \(String(format: Constants.StringFormat.zeroDigit, array.setPrice)) per seat")
                        .font(.system(size: 18, weight: .semibold ,design: .rounded))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    Group{
                        HStack{
                            Image(systemName: Constants.Images.calendar)
                            Text(DateTimeFormat.shared.dateFormat(date: array.date))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Image(systemName: Constants.Images.clock)
                            if let sourceTime = array.estimateTime{
                                Text(DateTimeFormat.shared.timeFormat(date: sourceTime, is24hrs: true, toNotReduce: false) + Constants.Description.hour)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Image(systemName: Constants.Images.person)
                            Text("\(array.passengersCount) seats left")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.system(size: 14, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .padding(.bottom)
                .foregroundColor(Color(.darkGray))
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .onAppear{
            publishedType = myRidesVM.toSetBookingType(type: array.status, bookedTab: false)
        }
    }
}

struct RidesPublishedCard_Previews: PreviewProvider {
    static var previews: some View {
        RidesPublishedCard(array: GetPublishResponse.initialize)
            .environmentObject(MyRidesViewModel())
    }
}
