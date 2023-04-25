//
//  AuthTextFieldViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

enum AuthFieldType {
    case email
    case password
    case fullname
    case username
}

struct AuthTextFieldViewViewModel {
    private let type: AuthFieldType
    
    var iconImage: UIImage? {
        switch type {
        case .email:
            return UIImage(systemName: "envelope")
        case .password:
            return UIImage(systemName: "lock")
        case .fullname:
            return UIImage(systemName: "person")
        case .username:
            return UIImage(systemName: "person.circle")

        }
    }
    
    var placeHolder: NSAttributedString {
        switch type {
        case .email:
            return placeHolderString(string: "Email")
        case .password:
            return placeHolderString(string: "Password")
        case .fullname:
            return placeHolderString(string: "Full Name")
        case .username:
            return placeHolderString(string: "Username")

        }
    }
    
    var isPassword: Bool {
        type == .password ? true : false
    }
    
    init(type: AuthFieldType) {
        self.type = type
    }
    
    private func placeHolderString(string: String) -> NSAttributedString {
        NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}
