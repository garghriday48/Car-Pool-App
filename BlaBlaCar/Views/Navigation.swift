//
//  NavigationView.swift
//  BlaBlaCar
//
//  Created by Pragath on 11/05/23.
//

import SwiftUI

struct Navigation: View {
    
    @EnvironmentObject var navigationVM: NavigationViewModel
    
    @StateObject var vm = AuthViewModel()
    @StateObject var carPoolVM = CarPoolRidesViewModel()
    @StateObject var mapVM = MapViewModel()
    @StateObject var profileVM = ProfileViewModel()
    @StateObject var myRidesVM = MyRidesViewModel()
    @StateObject var errorVM = ResponseErrorViewModel.shared
    @StateObject var messageVM = MessagesViewModel()
    
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
                    case .carPoolPublish: RouteSelectionView(mapVM: mapVM, carPoolVM: carPoolVM, myRidesVM: myRidesVM)
                    case .carPoolBook: AllRidesView(carPoolVM: carPoolVM)
                    }
                }
        }
        .environmentObject(carPoolVM)
        .environmentObject(vm)
        .environmentObject(profileVM)
        .environmentObject(myRidesVM)
        .environmentObject(mapVM)
        .environmentObject(errorVM)
        .environmentObject(messageVM)
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
            .environmentObject(NavigationViewModel())
    }
}
