//
//  AuthModel.swift
//  Shelves
//
//  Created by Мявкo on 11.09.23.
//

import Foundation

struct UserData {
    var email: String
    var password: String
}

struct AuthModel {
    static let loginData = UserData(email: "", password: "")
}
