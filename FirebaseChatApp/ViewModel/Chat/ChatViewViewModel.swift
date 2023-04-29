//
//  ChatViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import Foundation

final class ChatViewViewModel {
    private let user: User
    public var messages = [Message]()
    public var observeMessages: (() -> Void)?
    
    public var username: String {
        user.username
    }
    
    public var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
    
    public func bindToMessages(_ block: @escaping () -> Void) {
        self.observeMessages = block
    }
    
    public func sendMessage(_ message: String) {
        ChatService.shared.uploadMessage(message, toUser: user) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let failure):
                print(failure)
                break
            }
        }
    }
    
    public func receiveMessage() {
        ChatService.shared.fetchMessages(forUser: user) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.messages = success
                self.observeMessages?()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
