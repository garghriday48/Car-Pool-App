//
//  Main.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct Main: View {
    
    @ObservedObject var vm: SignInSignUpViewModel
    @ObservedObject var navigationVM: NavigationViewModel
    
    var body: some View {
        Text("Main page")
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(vm: SignInSignUpViewModel(), navigationVM: NavigationViewModel())
    }
}
