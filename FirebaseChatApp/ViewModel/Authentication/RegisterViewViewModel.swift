//
//  RegisterViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 26.04.2023.
//

import UIKit
import FirebaseStorage

struct RegisterViewViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    var profileImage: UIImage?
    
    var isFormValid: Bool {
        return !(email?.isEmpty ?? true)
        && !(password?.isEmpty ?? true)
        && !(fullname?.isEmpty ?? true)
        && !(username?.isEmpty ?? true)
    }
    
    public func register() {
        guard let imageData = profileImage?.jpegData(compressionQuality: 0.3) else { return }
        
        guard let email = email?.lowercased() else { return }
        guard let password = password?.lowercased() else { return }
        guard let username = username?.lowercased() else { return }
        guard let fullname = fullname?.lowercased() else { return }
        let registerInfo = RegisterationModel(email: email, password: password, username: username, fullname: fullname)
        
        AuthenticationService.shared.registerUser(registerInfo, imageData: imageData) { result in
            switch result {
            case .success(let success):
                print("DEBUG: Succesful registeration: \(success)")
            case .failure(let failure):
                print("DEBUG: Failed registeration: \(failure.localizedDescription)")
            }
        }
    }
}
