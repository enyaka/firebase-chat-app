//
//  ConversationsViewController.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit
import FirebaseAuth

final class ConversationsViewController: UIViewController {
    
    private let conservationsView = ConservationsView()

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
        view.addSubview(conservationsView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            conservationsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            conservationsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            conservationsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            conservationsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

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
