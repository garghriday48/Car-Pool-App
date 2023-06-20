//
//  RecentSearchesView.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/05/23.
//

import SwiftUI

struct RecentSearchesView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            HStack{
                BackButton(image: Constants.Images.backArrow) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.title)
                .bold()
                Text(Constants.Headings.recentSearches)
                    .font(.title3)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            .padding(.bottom)
            
            ScrollView{
                ForEach(0..<9){ _ in
                    HStack{
                        VStack(alignment: .leading, spacing: 7){
                            HStack{
                                Text("Gurgaon")
                                Spacer()
                                Image(systemName: "arrow.right")
                                Spacer()
                                Text("Meerut")
                            }
                            .font(.title3)
                            Text("Today, 11:00 AM")
                                .font(.subheadline)
                        }
                        .padding()
                        .padding(.horizontal)
                        .frame(alignment: .leading)
                        .background(Color(uiColor: UIColor.systemGray5))
                        .cornerRadius(25)
                        .padding(.bottom)
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
    }
}

struct RecentSearchesView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchesView()
    }
}
