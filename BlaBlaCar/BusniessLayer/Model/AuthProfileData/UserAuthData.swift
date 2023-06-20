//
//  UserAuthData.swift
//  BlaBlaCar
//
//  Created by Pragath on 11/05/23.
//

import Foundation


struct UserAuthData: Codable {
    var user: User
    
    func makeDict() -> [String: Any] {
        return ["user": ["email": user.email, "password": user.password, "first_name": user.firstName, "last_name": user.lastName, "dob": user.dob, "title": user.title]]
    }
}

struct User: Codable {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var dob: String
    var title: String
    
    
    enum CodingKeys: String, CodingKey{
        case email
        case password
        case firstName = "first_name"
        case lastName = "last_name"
        case dob
        case title
    }
}




