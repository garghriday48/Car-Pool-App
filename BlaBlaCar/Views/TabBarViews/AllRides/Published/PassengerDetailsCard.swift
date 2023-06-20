//
//  PassengerDetailsCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 14/06/23.
//

import SwiftUI

struct PassengerDetailsCard: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    var array: Passengers
    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                BackButton(image: Constants.Images.backArrow) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.title)
                .bold()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            .padding(.bottom)
            
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading) {
                        Text(array.firstName + " " + array.lastName)
                            .font(.largeTitle)
                        Text("\(Age.shared.calcAge(birthday: array.dob)) y/o")
                    }
                    
                    Spacer()
                    
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
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(lineWidth: 1)
                        }
                    }
                }
                .padding(.bottom, 40)
                Text("\(array.seats)") +
                Text(array.seats == 1 ? Constants.Description.seatBooked : Constants.Description.seatsBooked )
                
            }
            .bold()
            .padding()
            
            DividerCapsule(height: 3, color: Color(.lightGray))
                .padding(.horizontal)
            
            
            VStack(spacing: 10) {
                Group{
                    Text("About").bold()
                        .font(.title2)
                        .padding(.bottom)
                    HStack {
                        Image(systemName: Constants.Images.person)
                        Text(array.bio ?? "")
                    }
                    HStack {
                        Image(systemName: Constants.Images.starFilled)
                        Text(array.averageRating ?? "0.0")
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
    }
}

struct PassengerDetailsCard_Previews: PreviewProvider {
    static var previews: some View {
        PassengerDetailsCard(array: Passengers(userID: 0, firstName: "Hriday", lastName: "Garg", dob: "2001-12-06", phoneNumber: "", phoneVerified: false, image: "", averageRating: "", bio: "", travelPreferences: "", seats: 2))
            .environmentObject(MyRidesViewModel())
    }
}
