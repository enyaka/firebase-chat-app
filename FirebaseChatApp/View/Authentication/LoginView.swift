//
//  LoginView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func goToRegister(_ loginView: LoginView)
    func userSignedIn(_ loginView: LoginView)
}

protocol AuthenticationViewProtocol {
    func checkFormStatus()
}

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
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemPurple
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var authStackView: UIStackView = {
        let authStack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        authStack.translatesAutoresizingMaskIntoConstraints = false
        authStack.axis = .vertical
        authStack.spacing = 18
        return authStack
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let goToRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        button.backgroundColor = .clear
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToRegisterTapped), for: .touchUpInside)
        return button
    }()
    
    public var delegate: LoginViewProtocol?
    
    private var viewModel = LoginViewViewModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addConstraints()
        configureNotificationObservers()
        bindToStateObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(imageView, authStackView, goToRegisterButton, spinner)
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
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            goToRegisterButton.rightAnchor.constraint(equalTo: rightAnchor),
            goToRegisterButton.leftAnchor.constraint(equalTo: leftAnchor),
            goToRegisterButton.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
    }
    private func bindToStateObserver() {
        viewModel.bindToState { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                self.loginButton.isEnabled = false
                self.spinner.startAnimating()
                break
            case .error(let error):
                print(error)
                self.loginButton.isEnabled = true
                self.spinner.stopAnimating()
                break
            case .loaded:
                    self.delegate?.userSignedIn(self)
                break
            }
        }
    }
    

    private func configureNotificationObservers() {
        emailContainerView.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordContainerView.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailContainerView.textField {
            viewModel.email = sender.text
        }
        
        if sender == passwordContainerView.textField {
            viewModel.password = sender.text
        }
        
        DispatchQueue.main.async {
            self.checkFormStatus()
        }
    }
    
    @objc func loginTapped() {
        viewModel.signInUser()
    }
    
    @objc func goToRegisterTapped() {
        delegate?.goToRegister(self)
    }
}

extension LoginView: AuthenticationViewProtocol {
    func checkFormStatus() {
        if viewModel.isFormValid {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
}
