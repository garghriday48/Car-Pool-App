//
//  AccountSettingsView.swift
//  BlaBlaCar
//
//  Created by Pragath on 19/05/23.
//

import SwiftUI

struct AccountSettingsView: View {
    
    @ObservedObject var vm: AuthViewModel
    @ObservedObject var profileVM: ProfileViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            HStack{
                BackButton(image: Constants.Images.backArrow) {
                    self.dismiss()
                }
                .font(.title3)
                
                Text(Constants.Headings.accountSettings)
                    .font(.system(size: 18, design: .rounded))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 1, color: .gray.opacity(0.5))
            
            ScrollView{
                VStack(alignment: .leading){
                    
                        Button {
                            vm.toShowChangePassword.toggle()
                        } label: {
                            HStack{
                                Text(DataArrays.accountSettingsArray[1])
                                Spacer()
                                Image(systemName: Constants.Images.rightArrow)
                            }
                            .padding(.vertical)
                        }
                        .foregroundColor(.primary)
                    
                    ForEach(0..<3){item in
                        HStack{
                            Text(DataArrays.accountSettingsLinksArray[item])
                            Spacer()
                            Image(systemName: Constants.Images.rightArrow)
                        }
                        .padding(.vertical)
                        
                    }
                    DividerCapsule(height: 1, color: .gray.opacity(0.5))
                }
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $vm.toShowChangePassword) {
            ChangePasswordView(profileVM: profileVM)
        }
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView(vm: AuthViewModel(), profileVM: ProfileViewModel())
    }
}
