//
//  PointToPointView.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct PointToPointView: View {
    
    var color: Color
    var height: Int
    
    var body: some View {
        VStack{
            Image(systemName: Constants.Images.circleInsideCircle)
                .frame(width: 10, height: 10)
            DottedLine()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .frame(width: 2, height: CGFloat(height))
            
            Image(systemName: Constants.Images.circleInsideCircle)
                .frame(width: 10, height: 10)
        }
        .foregroundColor(color)
    }
}

struct PointToPointView_Previews: PreviewProvider {
    static var previews: some View {
        PointToPointView(color: .red, height: 52)
    }
}

struct DottedLine: Shape {
        
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}
