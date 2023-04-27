//
//  UserService.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import Foundation
import FirebaseFirestore

final class UserService {
    static let shared = UserService()
    private init() {}
    
    public func fetchUsers(completion: @escaping (Result<[User], CostumError>) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { [weak self] snapshot, error in
            if let error = error {
                completion(.failure(.failedToFetchData(error.localizedDescription)))
                return
            }
            guard let documents = snapshot?.documents else { return }
            documents.forEach { data in
                do {
                    let user = try data.data(as: User.self)
                    users.append(user)
                } catch {
                    completion(.failure(.failedToConvertDictionary))
                    return
                }
            }
            completion(.success(users))
        }
    }
}
