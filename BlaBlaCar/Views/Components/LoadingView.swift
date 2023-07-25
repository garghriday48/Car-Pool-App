//
//  LoadingView.swift
//  BlaBlaCar
//
//  Created by Pragath on 26/05/23.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var isLoading: Bool
    var size: Int
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color(Color.redColor), lineWidth: 3)
            .frame(width: CGFloat(size), height: CGFloat(size))
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(Animation.default.repeatForever(autoreverses: false), value: isLoading)
            .onAppear {
                withAnimation {
                    isLoading = true
                }
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(false), size: 40)
    }
}
