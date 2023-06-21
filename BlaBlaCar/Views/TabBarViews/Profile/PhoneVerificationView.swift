//
//  PhoneVerificationView.swift
//  BlaBlaCar
//
//  Created by Pragath on 20/06/23.
//

import SwiftUI

struct PhoneVerificationView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @ObservedObject var profileVM: ProfileViewModel
    
    
    var body: some View {
        VStack {
            HStack{
                BackButton(image: Constants.Images.cross) {
                    self.dismiss()
                    profileVM.phoneVerificationSteps = .numberView
                }
                .font(.title)
                .bold()
                
                Text(Constants.Headings.phoneVerification)
                    .font(.title3)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,alignment: .topLeading)
            }
            .padding()
            DividerCapsule(height: 4, color: Color(.systemGray3))
                .padding(.bottom)
            
            Text("Step \(Int(profileVM.phoneVerificationSteps.rawValue/50)) of 2")
                .font(.headline)
                .foregroundColor(Color(Color.redColor))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            ProgressBar(percent: profileVM.phoneVerificationSteps.rawValue)
                .animation(.easeOut, value: profileVM.phoneVerificationSteps.rawValue)
            
            switch profileVM.phoneVerificationSteps {
            case .numberView : PhoneInputView(profileVM: profileVM)
            case .numberOtpView: OtpInputView()
            }
        }
        .frame(maxHeight: .infinity,alignment: .top)
        .padding(.vertical)
    }
}

struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerificationView(profileVM: ProfileViewModel())
    }
}
