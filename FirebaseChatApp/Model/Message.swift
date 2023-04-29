//
//  Message.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 29.04.2023.
//

import Firebase

struct Message {
    let text: String
    let toId: String
    let fromId: String
    let timestamp: Timestamp!
    let isFromCurrentUser: Bool
    var user: User?
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
    }
}
