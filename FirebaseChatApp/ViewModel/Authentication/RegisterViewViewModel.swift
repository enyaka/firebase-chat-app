//
//  RegisterViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 26.04.2023.
//

import UIKit
import FirebaseStorage

final class RegisterViewViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    var profileImage: UIImage?
    
    private var currentState: ((CostumGlobalStates) -> Void)?
    
    var isFormValid: Bool {
        return !(email?.isEmpty ?? true)
        && !(password?.isEmpty ?? true)
        && !(fullname?.isEmpty ?? true)
        && !(username?.isEmpty ?? true)
    }
    
    public func bindToState(_ bind: @escaping (CostumGlobalStates) -> Void) {
        self.currentState = bind
    }
    
    public func register() {
        guard let imageData = profileImage?.jpegData(compressionQuality: 0.3) else { return }
        
        guard let email = email?.lowercased() else { return }
        guard let password = password?.lowercased() else { return }
        guard let username = username?.lowercased() else { return }
        guard let fullname = fullname?.lowercased() else { return }
        let registerInfo = RegisterationModel(email: email, password: password, username: username, fullname: fullname)
        
        AuthenticationService.shared.registerUser(registerInfo, imageData: imageData) { [weak self] result in
            guard let self else { return }
            self.currentState?(.loading)
            switch result {
            case .success(let success):
                self.currentState?(.loaded)
            case .failure(let failure):
                self.currentState?(.error(failure.localizedDescription))
            }
        }
    }
}
