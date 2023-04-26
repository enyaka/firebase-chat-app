//
//  LoginViewController.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        loginView.delegate = self
        configureGradientBackgroud()
        view.addSubview(loginView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            loginView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}

extension LoginViewController: LoginViewProtocol {
    func userSignedIn(_ loginView: LoginView) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    func goToRegister(_ loginView: LoginView) {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
