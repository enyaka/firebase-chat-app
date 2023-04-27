//
//  NewMessageViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import Foundation

final class NewMessageViewViewModel {
    
    public var users: [User] = []
    private var currentEvent: ((CostumGlobalEvents) -> Void)?
    
    public func bindToCurrentEvent(_ block: @escaping (CostumGlobalEvents) -> Void) {
        self.currentEvent = block
    }
    
    public func fetchAllUsers() {
        currentEvent?(.loading)
        UserService.shared.fetchUsers { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.users = success
                self.currentEvent?(.loaded)
            case .failure(let failure):
                self.currentEvent?(.error(failure.localizedDescription))
            }
        }
    }
}
