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
}

struct AuthTextFieldViewViewModel {
    private let type: AuthFieldType
    
    var iconImage: UIImage? {
        switch type {
        case .email:
            return UIImage(systemName: "envelope")
        case .password:
            return UIImage(systemName: "lock")
        }
    }
    
    var placeHolder: NSAttributedString {
        switch type {
        case .email:
            return NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        case .password:
            return NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        }
    }
    
    init(type: AuthFieldType) {
        self.type = type
    }
}
