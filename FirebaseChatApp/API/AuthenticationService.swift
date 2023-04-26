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
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        ref.putData(imageData) { [weak self] meta, error in
            if let error = error {
                completion(.failure(.failedToUploadImage(error.localizedDescription)))
                return
            }
            ref.downloadURL { [weak self] url, error in
                if let error = error {
                    completion(.failure(.failedToDownloadImageUrl(error.localizedDescription)))
                    return
                }
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: registerInfo.email, password: registerInfo.password) { [weak self] result, error in
                    if let error = error {
                        completion(.failure(.failedToRegisterUser(error.localizedDescription)))
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    do {
                        var documentData = try registerInfo.asDictionary()
                        documentData.updateValue(profileImageUrl, forKey: "profileImageUrl")
                        documentData.updateValue(uid, forKey: "uid")
                        Firestore.firestore().collection("users").document(uid).setData(documentData) { [weak self] error in
                            if let error = error {
                                completion(.failure(.failedToUpdateDatabase(error.localizedDescription)))
                            }
                            completion(.success(true))
                        }
                        
                    } catch {
                        completion(.failure(.failedToConvertDictionary))
                    }
                }
            }
        }
        
    }
}
