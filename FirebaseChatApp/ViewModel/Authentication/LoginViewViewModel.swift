//
//  LoginViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import Foundation

protocol AuthenticationViewModelProtocol {
    var isFormValid: Bool { get }
}

enum CostumGlobalEvents {
    case loading
    case error(String)
    case loaded
}

final class LoginViewViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    
    private var currentEvent: ((CostumGlobalEvents) -> Void)?
    
    var isFormValid: Bool {
        return !(email?.isEmpty ?? true) && !(password?.isEmpty ?? true)
    }
    
    public func bindToEvent(_ bind: @escaping (CostumGlobalEvents) -> Void) {
        self.currentEvent = bind
    }
    
    public func signInUser() {
        guard let email else { return }
        guard let password else { return }
        self.currentEvent?(.loading)

        AuthenticationService.shared.signInUser(email: email, password: password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.currentEvent?(.loaded)
            case .failure(let failure):
                self.currentEvent?(.error(failure.localizedDescription))
            }
        }
    }
}
