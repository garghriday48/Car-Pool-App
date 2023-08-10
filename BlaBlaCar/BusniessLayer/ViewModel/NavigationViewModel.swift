//
//  NavigationViewModel.swift
//  BlaBlaCar
//
//  Created by Pragath on 11/05/23.
//


import Foundation



class NavigationViewModel:ObservableObject{
    
    static let navigationVM = NavigationViewModel()
    
    @Published var paths: [ViewID] = []
    @Published var tabView: Int = 0
    
    init (){
    
        if UserDefaults.standard.string(forKey: Constants.UserDefaultKeys.session) != nil && UserDefaults.standard.string(forKey: Constants.UserDefaultKeys.session) != ""{
            paths = [.TabBarPage]
        }
        
    }
    
    
    // MARK: function to push view in array
    func push(_ path: ViewID) {
        paths.append(path)
    }
    
    // MARK: function to pop views based on the selected view
    func pop(to: ViewID) {
            guard let found = paths.firstIndex(where: { $0 == to }) else {
                return
            }

            let numToPop = (found..<paths.endIndex).count - 1
            paths.removeLast(numToPop)
        }
}

