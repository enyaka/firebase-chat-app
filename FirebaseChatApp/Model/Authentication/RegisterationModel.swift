//
//  RegisterationModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 26.04.2023.
//

import Foundation

struct RegisterationModel: Codable {
    let email: String
    let password: String
    let username: String
    let fullname: String
    
    init(email: String, password: String, username: String, fullname: String) {
        self.email = email
        self.password = password
        self.username = username
        self.fullname = fullname
    }
}
