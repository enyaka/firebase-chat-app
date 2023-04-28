//
//  ChatViewController.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import UIKit

final class ChatViewController: UIViewController {
    private let chatView: ChatView
    
    init(user: User) {
        self.chatView = ChatView(viewModel: ChatViewViewModel(user: user))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(chatView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            chatView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            chatView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            chatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
