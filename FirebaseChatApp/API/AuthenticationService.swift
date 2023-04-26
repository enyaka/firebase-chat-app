//
//  AuthenticationService.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 26.04.2023.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class AuthenticationService {
    static let shared = AuthenticationService()
    private init() {}
    
    public func registerUser(_ registerInfo: RegisterationModel, imageData: Data, completion: @escaping (Result<Bool, CostumError>) -> Void) {
        Auth.auth().createUser(withEmail: registerInfo.email, password: registerInfo.password) { [weak self] result, error in
            guard let self else { return }
            if let error = error {
                completion(.failure(.failedToRegisterUser(error.localizedDescription)))
                return
            }
            guard let uid = result?.user.uid else { return }
            
            self.uploadProfilePhoto(imageData) { [weak self] url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let profileImageUrl = url else { return }
                do {
                    var documentData = try registerInfo.asDictionary()
                    documentData.updateValue(profileImageUrl, forKey: "profileImageUrl")
                    documentData.updateValue(uid, forKey: "uid")
                    Firestore.firestore().collection("users").document(uid).setData(documentData) { [weak self] error in
                        if let error = error {
                            completion(.failure(.failedToUpdateDatabase(error.localizedDescription)))
                            return
                        }
                        completion(.success(true))
                        return
                    }
                    
                } catch {
                    completion(.failure(.failedToConvertDictionary))
                    return
                }
            }
            
        }
    }
    public func signInUser(email: String, password: String, completion: @escaping(Result<Bool, CostumError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(.failedToSingIn(error.localizedDescription)))
                return
            }
            completion(.success(true))
        }
    }
    
    private func uploadProfilePhoto(_ imageData: Data, completion: @escaping(String?, CostumError?) -> Void) {
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        ref.putData(imageData) { [weak self] meta, error in
            if let error = error {
                completion(nil, .failedToUploadImage(error.localizedDescription))
                return
            }
            ref.downloadURL { [weak self] url, error in
                if let error = error {
                    completion(nil, .failedToDownloadImageUrl(error.localizedDescription))
                    return
                }
                guard let profileImageUrl = url?.absoluteString else { return }
                completion(profileImageUrl, nil)
            }
        }
    }
}

