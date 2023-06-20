//
//  DividerCapsule.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct DividerCapsule: View {
    
    var height: Int
    var color: Color
    
    var body: some View {
        Capsule()
            .frame(maxWidth: .infinity, minHeight: CGFloat(height), maxHeight: CGFloat(height))
            .foregroundColor(color)
    }
}

struct DividerCapsule_Previews: PreviewProvider {
    static var previews: some View {
        DividerCapsule(height: 2, color: Color(.systemGray3))
    }
}
