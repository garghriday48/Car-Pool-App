//
//  ImageView.swift
//  BlaBlaCar
//
//  Created by Pragath on 14/08/23.
//

import SwiftUI

struct ImageView: View {
    
    var size: CGFloat
    var imageName: String?
    var condition: Bool
    
    @State var isLoading = true
    
    var body: some View {
        
        Group{
            if let image = imageName {
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                    
                    
                } placeholder: {
                    if condition || !self.isLoading{
                        
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
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(lineWidth: 1)
                .foregroundColor(.black)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                self.isLoading = false
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(size: 60, condition: false)
    }
}
