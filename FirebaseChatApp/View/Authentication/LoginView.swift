//
//  LoginView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

final class LoginView: UIView {
    
    private let imageView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.image = UIImage(systemName: "bubble.right")
        iView.tintColor = .white
        return iView
    }()
    
    private let emailContainerView: AuthTextFieldView = {
        let view = AuthTextFieldView(viewModel: AuthTextFieldViewViewModel(type: .email))
        return view
    }()
    
    private let passwordContainerView: AuthTextFieldView = {
        let view = AuthTextFieldView(viewModel: AuthTextFieldViewViewModel(type: .password))
        return view
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var authStackView: UIStackView = {
        let authStack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        authStack.translatesAutoresizingMaskIntoConstraints = false
        authStack.axis = .vertical
        authStack.spacing = 16
        return authStack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(imageView, authStackView)
    }
    
    private func addConstraints() {
        
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            
            emailContainerView.heightAnchor.constraint(equalToConstant: 40),
            passwordContainerView.heightAnchor.constraint(equalToConstant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            authStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            authStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            authStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),

        ])
    }
    
    @objc func loginTapped() {
        print("DEBUG: Login Tapped")
    }

}
