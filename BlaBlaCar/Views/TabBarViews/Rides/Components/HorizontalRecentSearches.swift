//
//  HorizontalRecentSearches.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI

struct HorizontalRecentSearches: View {
    
    
    
    var body: some View {
        VStack{
            DividerCapsule(height: 5, color: Color(.systemGray2))
            HStack{
                Text(Constants.Headings.recentSearches)
                    .font(.title2)
                    .bold()
                Spacer()
                NavigationLink {
                    RecentSearchesView()
                } label: {
                    Text(Constants.ButtonsTitle.seeAll)
                        .foregroundColor(Color(.systemGray2))
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal){
                HStack{
                    ForEach(0..<4){ _ in
                        
                        VStack(alignment: .leading, spacing: 7){
                            HStack{
                                Text("Gurgaon")
                                Image(systemName: Constants.Images.bigRightArrow)
                                Text("Meerut")
                            }
                            .font(.title3)
                            Text("Today, 11:00 AM")
                                .font(.subheadline)
                        }
                        .padding()
                        .padding(.horizontal)
                        .background(Color(uiColor: UIColor.systemGray5))
                        .frame(maxWidth: .infinity)
                        .cornerRadius(25)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
        }
    }
}

struct HorizontalRecentSearches_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalRecentSearches()
    }
}
