//
//  ChatService.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 29.04.2023.
//

import Firebase

final class ChatService {
    static let shared = ChatService()
    private init() {}
    
    public func uploadMessage(_ message: String, toUser: User, completion: @escaping (Result<Void, CostumError>) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": toUser.uid,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        Firestore.firestore().collection("messages").document(currentUid).collection(toUser.uid).addDocument(data: data) { [weak self] error in
            if let error = error {
                completion(.failure(.failedToSendMessage(error.localizedDescription)))
                return
            }
            Firestore.firestore().collection("messages").document(toUser.uid).collection(currentUid).addDocument(data: data) { [weak self] error in
                if let error = error {
                    completion(.failure(.failedToSendMessage(error.localizedDescription)))
                    return
                }
                completion(.success(()))
            }
        }
    }
    
    public func fetchMessages(forUser user: User, completion: @escaping (Result<[Message], CostumError>) -> Void) {
        var messages = [Message]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("messages").document(currentUid).collection(user.uid).order(by: "timestamp").addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(.failedToFetchData(error.localizedDescription)))
                return
            }
            guard let snapshot else { return }
            snapshot.documentChanges.forEach { change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictionary: dictionary))
                    completion(.success(messages))
                }
            }
            
        }
    }
}
