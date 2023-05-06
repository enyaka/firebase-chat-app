//
//  ConservationsViewViewModel.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 1.05.2023.
//

import Foundation

final class ConservationsViewViewModel {
    public var conservations = [Conservation]()
    private var observeConservations: ((CostumGlobalEvents) -> Void)?
     
    public func bindToEvent(_ block: @escaping (CostumGlobalEvents) -> Void){
        self.observeConservations = block
    }

    public func fetchConservations() {
        self.observeConservations?(.loading)
        ChatService.shared.fetchConservations { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let success):
                self.conservations = success
                self.observeConservations?(.loaded)
            case .failure(let failure):
                self.observeConservations?(.error(failure.localizedDescription))
            }
        }
    }
}
