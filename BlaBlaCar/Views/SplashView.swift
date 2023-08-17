//
//  SplashView.swift
//  BlaBlaCar
//
//  Created by Pragath on 16/08/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                Navigation()
            } else {
                VStack{
                    Image("splashImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .foregroundColor(Color(Color.redColor))
                    Text("Car Pool")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                    Text("Together We Ride, Together We Thrive")
                        .font(.system(size: 18, weight: .none, design: .rounded))
                    
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
