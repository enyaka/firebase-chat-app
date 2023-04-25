//
//  RegisterView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func popToLogin()
}

final class RegisterView: UIView {
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "add_photo.png"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addPhotoTapped), for: .touchUpInside)
        return button
    }()
    
    private let emailContainerView: AuthTextFieldView = {
        let view = AuthTextFieldView(viewModel: AuthTextFieldViewViewModel(type: .email))
        return view
    }()
    
    private let fullnameContainerView: AuthTextFieldView = {
        let view = AuthTextFieldView(viewModel: AuthTextFieldViewViewModel(type: .fullname))
        return view
    }()
    
    private let usernameContainerView: AuthTextFieldView = {
        let view = AuthTextFieldView(viewModel: AuthTextFieldViewViewModel(type: .username))
        return view
    }()
    
    private let passwordContainerView: AuthTextFieldView = {
        let view = AuthTextFieldView(viewModel: AuthTextFieldViewViewModel(type: .password))
        return view
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var authStackView: UIStackView = {
        let authStack = UIStackView(arrangedSubviews: [emailContainerView, fullnameContainerView, usernameContainerView, passwordContainerView, signUpButton])
        authStack.translatesAutoresizingMaskIntoConstraints = false
        authStack.axis = .vertical
        authStack.spacing = 16
        return authStack
    }()
    
    private let goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedTitle = NSMutableAttributedString(string: "Already have an account ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        button.backgroundColor = .clear
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToLoginTapped), for: .touchUpInside)
        return button
    }()
    
    public var delegate: RegisterViewProtocol?

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
        addSubviews(plusPhotoButton, authStackView, goToLoginButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            plusPhotoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusPhotoButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            plusPhotoButton.heightAnchor.constraint(equalToConstant: 150),
            plusPhotoButton.widthAnchor.constraint(equalToConstant: 150),
            
            emailContainerView.heightAnchor.constraint(equalToConstant: 40),
            passwordContainerView.heightAnchor.constraint(equalToConstant: 40),
            usernameContainerView.heightAnchor.constraint(equalToConstant: 40),
            fullnameContainerView.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            
            authStackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 32),
            authStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            authStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            
            goToLoginButton.rightAnchor.constraint(equalTo: rightAnchor),
            goToLoginButton.leftAnchor.constraint(equalTo: leftAnchor),
            goToLoginButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc func addPhotoTapped() {
        
    }
    
    @objc func signUpTapped() {
        
    }
    
    @objc func goToLoginTapped() {
        delegate?.popToLogin()
    }
}
