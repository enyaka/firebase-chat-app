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

struct LoginViewViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    
    var isFormValid: Bool {
        return !(email?.isEmpty ?? true) && !(password?.isEmpty ?? true)
    }
}
