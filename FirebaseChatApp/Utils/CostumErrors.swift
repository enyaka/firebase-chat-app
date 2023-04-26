//
//  CostumErrors.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 26.04.2023.
//

import Foundation

enum CostumError: Error {
    case failedToConvertDictionary
    case failedToUploadImage(String)
    case failedToDownloadImageUrl(String)
    case failedToRegisterUser(String)
    case failedToUpdateDatabase(String)
    case failedToSingIn(String)
}

extension CostumError: LocalizedError {
    public var errorDescription: String? {
            switch self {
            case .failedToConvertDictionary:
                return NSLocalizedString("Cannot convert Model to Dictionary", comment: "My error")
            case .failedToUploadImage(let error):
                return NSLocalizedString(error, comment: "My error")
            case .failedToDownloadImageUrl(let error):
                return NSLocalizedString(error, comment: "My error")
            case .failedToRegisterUser(let error):
                return NSLocalizedString(error, comment: "My error")
            case .failedToUpdateDatabase(let error):
                return NSLocalizedString(error, comment: "My error")
            case .failedToSingIn(let error):
                return NSLocalizedString(error, comment: "My error")
            }
        }
}

