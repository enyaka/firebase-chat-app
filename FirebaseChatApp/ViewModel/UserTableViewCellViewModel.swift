//
//  UserTableViewCellViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import Foundation

struct UserTableViewCellViewModel {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    public var username: String {
        user.username
    }
    
    public var fullname: String {
        user.fullname
    }
    
    public var profileImageUrl: URL? {
        URL(string: user.profileImageUrl)
    }
}
