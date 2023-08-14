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
            ImageView(size: 60,
                      imageName: array.image,
                      condition: array.image == "")

            
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
