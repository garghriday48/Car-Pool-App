//
//  PlaceholderView.swift
//  BlaBlaCar
//
//  Created by hriday garg on 03/06/23.
//

import SwiftUI

struct PlaceholderView: View {
    
    // MARK: - properties
    
    var image: String
    var title: String
    var caption: String
    var needBackBtn: Bool
    var height:CGFloat = 194
    var width:CGFloat = 300
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            if needBackBtn {
                HStack{
                    BackButton(image: Constants.Images.backArrow) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.title)
                    .bold()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)
            }
            
            VStack{
                // image view
                Image(image)
                    .resizable()
                    .frame(width: width, height: height)
                    .padding()
                
                // title text
                Text(title)
                    .font(
                        .system(
                            size   : 22,
                            weight : .semibold,
                            design : .rounded
                        )
                    )
                    .padding(.top, 14)
                
                // caption text
                Text(caption)
                    .font(.system(size: 14, design: .rounded))
                    .padding(.top, 2)
                    .foregroundColor(.gray)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 44)
        }
        .frame(maxHeight: .infinity)
        .navigationBarBackButtonHidden()

    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(image: Constants.EmptyView.image, title: Constants.EmptyView.title, caption: Constants.EmptyView.caption, needBackBtn: true)
    }
}
