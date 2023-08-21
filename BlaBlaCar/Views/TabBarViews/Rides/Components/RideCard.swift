//
//  RideCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct RideCard: View {
    
    @EnvironmentObject var vm: AuthViewModel
    @ObservedObject var carPoolVM: CarPoolRidesViewModel
    
    @Binding var array: DataArray
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 7){
                HStack{
                    Group {
                        Text(array.publish.source)
                        Image(systemName: Constants.Images.bigRightArrow)
                        Text(array.publish.destination)
                    }
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.leading)
                    Spacer()
                    Text("Rs \(Int(array.publish.setPrice))")
                        .font(.system(size: 18, design: .rounded))
                }
                .lineLimit(2)
                .foregroundColor(.black)
                
                HStack{
                    Text("\(DateTimeFormat.shared.timeFormat(date: array.publish.time, is24hrs: false, toNotReduce: false)) to \(DateTimeFormat.shared.timeFormat(date: array.reachTime, is24hrs: false, toNotReduce: false))")
                    Spacer()
                    Text(array.publish.passengersCount == 1 ? "\(array.publish.passengersCount) \(Constants.Description.seat)" : "\(array.publish.passengersCount) \(Constants.Description.seats)")
                }
                .font(.system(size: 14, design: .rounded))
                .padding(.bottom)
                .foregroundColor(Color(.darkGray))
                HStack{
                    Image(systemName: Constants.Images.walkingFig)
                        .foregroundColor(.yellow)
                    Text(Constants.Description.distToWalk)
                    Image(systemName: Constants.Images.rightArrow)
                    Image(systemName: Constants.Images.car)
                        .frame(width: 30, height:  30)
                    Image(systemName: Constants.Images.rightArrow)
                    Image(systemName: Constants.Images.walkingFig)
                        .foregroundColor(.green)
                    Text(Constants.Description.distToWalk)
                }
                .font(.system(size: 14, design: .rounded))
                .foregroundColor(Color(.darkGray))
                
                DividerCapsule(height: 1, color: .gray.opacity(0.3))
                HStack {
                    ImageView(size: 60,
                              imageName: array.imageURL,
                              condition: array.imageURL == nil)
//                    AsyncImage(url: array.imageURL) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFill()
//                            } placeholder: {
//                                if array.imageURL == nil {
//                                    Image(Constants.Images.person)
//                                        .resizable()
//                                        .scaledToFill()
//                                } else {
//                                    ZStack {
//                                        Color.gray.opacity(0.1)
//                                        ProgressView()
//                                    }
//                                }
//                            }
//                        .clipShape(Circle())
//                        .frame(width: 60, height: 60)
//                        .overlay {
//                            Circle().stroke(lineWidth: 1)
//                        }
                    VStack(alignment: .leading, spacing: 4){
                        Text(array.name)
                            .foregroundColor(.black)
                            .font(.system(size: 18, design: .rounded))
                        HStack{
                            Text("4.5")
                            Image(systemName: Constants.Images.starFilled)
                            Circle()
                                .frame(width: 5, height: 5)
                            Text("27 Ratings")
                        }
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color(.darkGray))
                        
                    }
                    Spacer()
                    Image(systemName: Constants.Images.facemask)
                        .foregroundColor(Color(.darkGray))
                    Image(systemName: Constants.Images.filledBag)
                        .foregroundColor(Color(.darkGray))
                }
                .padding(.vertical)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

struct RideCard_Previews: PreviewProvider {
    static var previews: some View {
        RideCard( carPoolVM: CarPoolRidesViewModel(), array: .constant(DataArray(id: 0, name: "", reachTime: "", imageURL: nil, averageRating: nil, aboutRide: "", publish: PublishResponse(id: 0, source: "chandigarh arportnfgshnsfhnsfhnsfnhnnfnnfsnfgn", destination: "delhi airport vfdnibgfrbnsfgrnsfnnsfnfsgnfsg", passengersCount: 0, addCity: "", date: "", time: "", setPrice: 0.0, aboutRide: "", userID: 0, createdAt: "", updatedAt: "", sourceLatitude: 0.0, sourceLongitude: 0.0, destinationLatitude: 0.0, destinationLongitude: 0.0, vehicleID: 0, bookInstantly: "", midSeat: "", selectRoute: SelectRoute(), status: "", estimateTime: "", addCityLongitude: 0.0, addCityLatitude: 0.0, distance: nil, bearing: nil))))
    }
}
