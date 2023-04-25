//
//  RegisterViewController.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

final class RegisterViewController: UIViewController {

    private let registerView = RegisterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        view.addSubview(registerView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            registerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            registerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
