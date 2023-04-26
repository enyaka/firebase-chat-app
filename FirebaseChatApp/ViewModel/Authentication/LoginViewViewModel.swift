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

enum CostumGlobalStates {
    case loading
    case error(String)
    case loaded
}

final class LoginViewViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    
    private var currentState: ((CostumGlobalStates) -> Void)?
    
    var isFormValid: Bool {
        return !(email?.isEmpty ?? true) && !(password?.isEmpty ?? true)
    }
    
    public func bindToState(_ bind: @escaping (CostumGlobalStates) -> Void) {
        self.currentState = bind
    }
    
    public func signInUser() {
        guard let email else { return }
        guard let password else { return }
        self.currentState?(.loading)

        AuthenticationService.shared.signInUser(email: email, password: password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.currentState?(.loaded)
            case .failure(let failure):
                self.currentState?(.error(failure.localizedDescription))
            }
        }
    }
}
