//
//  ProgressBar.swift
//  BlaBlaCar
//
//  Created by hriday garg on 11/05/23.
//

import SwiftUI

struct ProgressBar: View {
    
    var percent: Float
    
    var body: some View {
        
        ZStack(alignment: .leading){
            GeometryReader{ geometry in
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 10)
                    .foregroundColor(.black.opacity(0.1))
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: geometry.size.width * CGFloat((percent/100)) ,height: 10)
                    .foregroundColor(Color(uiColor: Color.redColor))
            }
        }.padding()
            .frame(height: 1)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(percent: 50)
    }
}
