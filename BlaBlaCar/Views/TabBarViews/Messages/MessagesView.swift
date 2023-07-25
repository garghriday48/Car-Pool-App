//
//  MessagesView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct MessagesView: View {
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @EnvironmentObject var messageVM: MessagesViewModel
    
    var body: some View {
        VStack{
            Text(Constants.Headings.messages)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity ,alignment: .topLeading)
                .padding()
            
            DividerCapsule(height: 4, color: Color(.systemGray3))
            
            List {
                ForEach(0..<3){_ in
                    PersonListCard()
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
            .environmentObject(MyRidesViewModel())
            .environmentObject(MessagesViewModel())
    }
}
