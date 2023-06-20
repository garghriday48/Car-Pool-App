//
//  NavigationView.swift
//  BlaBlaCar
//
//  Created by Pragath on 11/05/23.
//

import SwiftUI

struct Navigation: View {
    
    @EnvironmentObject var navigationVM: NavigationViewModel
    
    @StateObject var vm = SignInSignUpViewModel()
    @StateObject var carPoolVM = CarPoolRidesViewModel()
    @StateObject var mapVM = MapViewModel()
    @StateObject var profileVM = ProfileViewModel()
    @StateObject var myRidesVM = MyRidesViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationVM.paths) {
            OnboardingView(vm: vm)

            // MARK: for choosing between different destinations
                .navigationDestination(for: ViewID.self) { path in
                    switch path {
                    case .OnboardingView: OnboardingView(vm: vm)
                    case .MainSigninSignupView: MainSignInSignUpView(vm: vm)
                    case .SignupPage: SignUpView()
                    case .LoginPage: LoginView()
                    case .TabBarPage: TabBarView()
                    case .carPoolPublish: RouteSelectionView(mapVM: mapVM, carPoolVM: carPoolVM)
                    case .carPoolBook: AllRidesView(carPoolVM: carPoolVM)
                    }
                }
        }
        .environmentObject(carPoolVM)
        .environmentObject(vm)
        .environmentObject(profileVM)
        .environmentObject(myRidesVM)
        .environmentObject(mapVM)
        //.environmentObject(navigationVM)
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
