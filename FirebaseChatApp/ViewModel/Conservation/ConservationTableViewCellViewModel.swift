//
//  ConservationTableViewCellViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 6.05.2023.
//

import Foundation

struct ConservationTableViewCellViewModel {
    private let conservation: Conservation
    
    public var username: String {
        conservation.user.username
    }
    
    public var message: String {
        conservation.message.text
    }
    
    public var profileImageUrl: URL? {
        URL(string:conservation.user.profileImageUrl)
    }
    
    public var timestamp: String {
        let date = conservation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    init(conservation: Conservation) {
        self.conservation = conservation
    }
}
