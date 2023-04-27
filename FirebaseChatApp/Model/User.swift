//
//  User.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import Foundation

struct User: Codable {
    let uid: String
    let email: String
    let fullname: String
    let username: String
    let profileImageUrl: String
}
