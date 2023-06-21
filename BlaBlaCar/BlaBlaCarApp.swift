//
//  BlaBlaCarApp.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

@main
struct BlaBlaCarApp: App {
    
    @StateObject var navigationVM = NavigationViewModel.navigationVM
    
    var body: some Scene {
        WindowGroup {
            Navigation()
                .environmentObject(navigationVM)
        }
        
    }
}
