//
//  PassengersCard.swift
//  BlaBlaCar
//
//  Created by Pragath on 14/06/23.
//

import SwiftUI

struct PassengersCard: View {
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    var array: Passengers
    
    var body: some View {
        HStack {
            Group{
                if let image = array.image {
                    AsyncImage(url: URL(string: image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        if array.image == ""{
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
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(lineWidth: 1)
            }
            
            VStack(alignment: .leading, spacing: 4){
                Text(array.firstName + " " + array.lastName)
                    .foregroundColor(.black)
                    .font(.title3)
                Text("\(Age.shared.calcAge(birthday: array.dob)) y/o")
                .font(.subheadline)
                .foregroundColor(Color(.darkGray))
            }
            Spacer()
            Image(systemName: Constants.Images.rightArrow)

       }
       .padding(.vertical)
       .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct PassengersCard_Previews: PreviewProvider {
    static var previews: some View {
        PassengersCard(array: Passengers(userID: 0, firstName: "Hriday", lastName: "Garg", dob: "2001-12-06", phoneNumber: "", phoneVerified: false, image: "", averageRating: "", bio: "", travelPreferences: "", seats: 2))
            .environmentObject(MyRidesViewModel())
    }
}
