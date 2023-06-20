//
//  AccountSettingsView.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import SwiftUI

struct AccountSettingsView: View {
    
    @ObservedObject var profileVM: ProfileViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            HStack{
                BackButton(image: Constants.Images.backArrow) {
                    self.dismiss()
                }
                .font(.title)
                .bold()
                
                Text(Constants.Headings.accountSettings)
                    .font(.title3)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 4, color: Color(.systemGray3))
            
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(0..<2){item in
                        HStack{
                            Text(DataArrays.accountSettingsArray[item])
                            Spacer()
                            Image(systemName: Constants.Images.rightArrow)
                        }
                        .padding(.vertical)
                        DividerCapsule(height: 2, color: Color(.systemGray3))
                    }
                    
                    ForEach(0..<3){item in
                        HStack{
                            Text(DataArrays.accountSettingsLinksArray[item])
                            Spacer()
                            Image(systemName: Constants.Images.rightArrow)
                        }
                        .padding(.vertical)
                        
                    }
                    DividerCapsule(height: 2, color: Color(.systemGray3))
                }
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView(profileVM: ProfileViewModel())
    }
}
