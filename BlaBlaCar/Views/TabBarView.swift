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
            .ignoresSafeArea()
            .environmentObject(carPoolVM)
            .environmentObject(profileVM)
            .onAppear{
                profileVM.vehicleListApiCall(method: .vehicleList, data: [:], httpMethod: .GET)
            }

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
