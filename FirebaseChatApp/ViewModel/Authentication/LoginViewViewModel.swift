//
//  LoginViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import Foundation


struct LoginViewViewModel {
    var email: String?
    var password: String?
    
    var isFormValid: Bool {
        return !(email?.isEmpty ?? true) && !(password?.isEmpty ?? true)
    }
}
