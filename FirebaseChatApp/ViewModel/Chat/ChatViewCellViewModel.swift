//
//  ChatViewCellViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 29.04.2023.
//

import UIKit

struct ChatViewCellViewModel {
    
    private let message: Message
    public let profileImageUrl: URL?

    public var messageText: String {
        return message.text
    }
    
    public var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .tertiaryLabel : .systemTeal
    }
    
    public var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }
    
    public var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    public var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    public var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    
    init(message: Message, profileImageUrl: URL?) {
        self.message = message
        self.profileImageUrl = profileImageUrl
    }
}
