//
//  ConversationsViewController.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

final class ConversationsViewController: UIViewController {
    
    private let conservationsView = ConservationsView()

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @objc func showProfile() {
        print("DEBUG: Show Profile")
    }

}
