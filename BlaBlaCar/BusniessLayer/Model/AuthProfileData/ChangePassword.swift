//
//  ChangePassword.swift
//  BlaBlaCar
//
//  Created by Pragath on 20/06/23.
//

import Foundation


struct ChangePassword: Codable {
    var current_password: String
    var password: String
    var password_confirmation: String
}

extension ChangePassword {
    static var initialize = ChangePassword(current_password: "", password: "", password_confirmation: "")
}
