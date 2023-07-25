//
//  TabBarView.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var navigationVM: NavigationViewModel
    @EnvironmentObject var vm: SignInSignUpViewModel
    @EnvironmentObject var carPoolVM: CarPoolRidesViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var mapVM: MapViewModel
    @EnvironmentObject var errorVM: ResponseErrorViewModel
    
    var body: some View {
            TabView{
                /// for each to show all the tabs in tabbar
                /// group is used so that their is no need to give each tab its image and name
                ForEach(TabViews.allCases, id: \.self){views in
                    Group{
                        switch views{
                        case .carPool: CarPoolView(mapVM: mapVM, carPoolVM: carPoolVM)
                        case .myRides: MyRidesView()
                        case .messages: MessagesView()
                        case .profile: ProfileView(vm: vm, profileVM: profileVM)
                        }
                    }
                    .padding(.bottom)
                    .tabItem {
                        Image(systemName: views.rawValue.image)
                        Text(views.rawValue.text)
                    }
                }
            }
            .blur(radius: errorVM.hasResponseError ? 5 : 0)
            .ignoresSafeArea()
            .environmentObject(carPoolVM)
            .environmentObject(profileVM)
            .environmentObject(errorVM)
            
            .alert(Constants.ErrorBox.error, isPresented: $errorVM.hasResponseError, actions: {
                Button(Constants.ErrorBox.okay, role: .cancel) {
                    if errorVM.errorMessage1 == Constants.ErrorBox.toLoginAgain {
                        navigationVM.paths = []
                    }
                }
            }, message: {
                Text(errorVM.errorMessage1)
            })

            .alert(Constants.ErrorBox.error, isPresented: $errorVM.hasError, actions: {
                Button(Constants.ErrorBox.okay, role: .cancel) {
                }
            }, message: {
                Text(errorVM.errorMessage?.errorDescription ?? "")
            })

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
