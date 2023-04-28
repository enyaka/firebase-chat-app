//
//  ChatViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import Foundation

final class ChatViewViewModel {
    private let user: User
    var username: String {
        user.username
    }
    init(user: User) {
        self.user = user
    }
}
