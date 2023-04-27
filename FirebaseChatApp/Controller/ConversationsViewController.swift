//
//  ConversationsViewController.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit
import FirebaseAuth

final class ConversationsViewController: UIViewController {
    
    private let conversationsView = ConversationsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserAuthenticate()
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Messages"
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        conversationsView.delegate = self
        view.addSubview(conversationsView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            conversationsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            conversationsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            conversationsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            conversationsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
    private func checkUserAuthenticate() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {

        }
    }
    
    @objc func showProfile() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("DEBUG: Auth error")

        }
    }
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
}

extension ConversationsViewController: ConversationsViewProtocol {
    func newMessage(_ conservationView: ConversationsView) {
        let controller = NewMessageViewController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(nav, animated: true)
        }
    }
}
