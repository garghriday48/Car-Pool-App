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
    @EnvironmentObject var messageVM: MessagesViewModel
    
    
    var body: some View {
        TabView(selection: $navigationVM.tabView){
                /// for each to show all the tabs in tabbar
                /// group is used so that their is no need to give each tab its image and name
                ForEach(TabViews.allCases, id: \.self){views in
                    Group{
                        switch views{
                        case .carPool: CarPoolView(mapVM: mapVM, carPoolVM: carPoolVM).tag(0)
                        case .myRides: MyRidesView().tag(1)
                        case .messages: MessagesView().tag(2)
                        case .profile: ProfileView(vm: vm, profileVM: profileVM).tag(3)
                        }
                    }
                    .padding(.bottom)
                    .tabItem {
                        Image(systemName: views.rawValue.image)
                        Text(views.rawValue.text)
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .accentColor(Color(Color.redColor).opacity(0.8))
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
            .onAppear{
                guard let id = UserDefaults.standard.value(forKey: Constants.UserDefaultKeys.userId) else {return}
                messageVM.senderId = id as? Int ?? 0
            }

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
