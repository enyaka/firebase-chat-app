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
    private let REF_MESSAGES = Firestore.firestore().collection("messages")
    
    public func uploadMessage(_ message: String, toUser: User, completion: @escaping (Result<Void, CostumError>) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": toUser.uid,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        REF_MESSAGES.document(currentUid).collection(toUser.uid).addDocument(data: data) { [weak self] error in
            guard let self else {return}
            if let error = error {
                completion(.failure(.failedToSendMessage(error.localizedDescription)))
                return
            }
            self.REF_MESSAGES.document(toUser.uid).collection(currentUid).addDocument(data: data) { [weak self] error in
                guard let self else {return}
                if let error = error {
                    completion(.failure(.failedToSendMessage(error.localizedDescription)))
                    return
                }
                self.REF_MESSAGES.document(currentUid).collection("recent-messages").document(toUser.uid).setData(data)
                self.REF_MESSAGES.document(toUser.uid).collection("recent-messages").document(currentUid).setData(data)
                completion(.success(()))
            }
        }
    }
    
    public func fetchMessages(forUser user: User, completion: @escaping (Result<[Message], CostumError>) -> Void) {
        var messages = [Message]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        REF_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp").addSnapshotListener { snapshot, error in
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
    
    public func fetchConservations(completion: @escaping (Result<[Conservation], CostumError>) -> Void) {
        var conservations = [Conservation]()
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        REF_MESSAGES.document(currentUid).collection("recent-messages").order(by: "timestamp").addSnapshotListener { [weak self] snapshot, error in
            guard let self else { return }
            if let error = error {
                completion(.failure(.failedToFetchData(error.localizedDescription)))
                return
            }
            guard let snapshot else { return }
            snapshot.documentChanges.forEach { change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                UserService.shared.fetchUser(uid: change.document.documentID) { [weak self] result in
                    switch result {
                    case .success(let success):
                        let conservation = Conservation(user: success, message: message)
                        conservations.append(conservation)
                        completion(.success(conservations))
                    case .failure(let failure):
                        completion(.failure(.failedToFetchData(failure.localizedDescription)))
                    }
                }
            }
        }
    }
}
