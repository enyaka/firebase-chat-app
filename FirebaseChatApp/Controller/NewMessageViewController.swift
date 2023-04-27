//
//  NewMessageViewController.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import UIKit

final class NewMessageViewController: UIViewController {
    
    private let newMessageView = NewMessageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "New Message"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        view.addSubview(newMessageView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            newMessageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newMessageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            newMessageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            newMessageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func dismissController() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

}
