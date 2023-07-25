//
//  RoundedShape.swift
//  BlaBlaCar
//
//  Created by Pragath on 03/07/23.
//

import SwiftUI

struct RoundedShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 30, height: 30))
        return Path(path.cgPath)
    }
}

