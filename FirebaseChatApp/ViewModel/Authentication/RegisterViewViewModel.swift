//
//  RegisterViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 26.04.2023.
//

import Foundation

struct RegisterViewViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var isFormValid: Bool {
        return !(email?.isEmpty ?? true)
        && !(password?.isEmpty ?? true)
        && !(fullname?.isEmpty ?? true)
        && !(username?.isEmpty ?? true)
    }
}
