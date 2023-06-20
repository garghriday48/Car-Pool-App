//
//  Combine.swift
//  BlaBlaCar
//
//  Created by Pragath on 22/05/23.
//

import SwiftUI

struct Combine: View {
    
    @StateObject var profileVM = ProfileViewModel()
    

    
    var body: some View {
        VStack{
            Text("\(profileVM.count )")
                .font(.largeTitle)
            Text("\(profileVM.combineArray[0].counting)")
            TextField("", text: $profileVM.combineArray[0].counting)
                .padding()
                .background(.gray)
                .padding()
        }

    }
}

struct Combine_Previews: PreviewProvider {
    static var previews: some View {
        Combine()
    }
}
