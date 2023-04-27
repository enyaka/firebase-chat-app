//
//  RegisterView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func registerView(_ registerView: RegisterView)
    func didSelectPhoto(_ registerView: RegisterView)
    func userRegistered(_ registerView: RegisterView)
    func showError(_ registerView: RegisterView, withError error: String)
}

final class RegisterView: UIView {
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "add_photo.png"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
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
        button.isEnabled = false
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
    
    public weak var delegate: RegisterViewProtocol?
    
    private var viewModel: RegisterViewViewModel = RegisterViewViewModel()

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
    
    public func changePlusPhotoImage(_ image: UIImage?) {
        guard let image = image else { return }
        viewModel.profileImage = image
        DispatchQueue.main.async {
            self.plusPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            self.plusPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
            self.plusPhotoButton.layer.borderWidth = 3.0
            self.plusPhotoButton.layer.cornerRadius = 150/2
        }
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.textField.delegate = self
        fullnameContainerView.textField.delegate = self
        usernameContainerView.textField.delegate = self
        passwordContainerView.textField.delegate = self
        emailContainerView.textField.resignFirstResponder()
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
    
    private func bindToStateObserver() {
        viewModel.bindToState { [weak self] state in
            guard let self else { return }
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self.signUpButton.isEnabled = false
                    self.handleLoader(true, withText: "Singin in")
                case .error(let error):
                    self.signUpButton.isEnabled = true
                    self.handleLoader(false)
                    self.delegate?.showError(self, withError: error)
                case .loaded:
                    self.handleLoader(false)
                    self.delegate?.userRegistered(self)
                }
            }
        }
    }
    
    private func configureNotificationObservers() {
        emailContainerView.textField.addTarget(self, action: #selector(textDidChange), for:
            .editingChanged)
        passwordContainerView.textField.addTarget(self, action: #selector(textDidChange), for:
            .editingChanged)
        usernameContainerView.textField.addTarget(self, action: #selector(textDidChange), for:
            .editingChanged)
        fullnameContainerView.textField.addTarget(self, action: #selector(textDidChange), for:
            .editingChanged)
    }
    

    
    @objc private func textDidChange(sender: UITextField) {
        switch sender {
        case emailContainerView.textField:
            viewModel.email = sender.text
        case passwordContainerView.textField:
            viewModel.password = sender.text
        case usernameContainerView.textField:
            viewModel.username = sender.text
        case fullnameContainerView.textField:
            viewModel.fullname = sender.text
        default:
            break
        }
        DispatchQueue.main.async {
            self.checkFormStatus()
        }
    }
    
    
    @objc func addPhotoTapped() {
        delegate?.didSelectPhoto(self)
    }
    
    @objc func signUpTapped() {
        viewModel.register()
    }
    
    @objc func goToLoginTapped() {
        delegate?.registerView(self)
    }
}

extension RegisterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailContainerView.textField:
            fullnameContainerView.textField.becomeFirstResponder()
        case fullnameContainerView.textField:
            usernameContainerView.textField.becomeFirstResponder()
        case usernameContainerView.textField:
            passwordContainerView.textField.becomeFirstResponder()
        case passwordContainerView.textField:
            signUpTapped()
        default:
            break
        }
        return true
    }
}

extension RegisterView: AuthenticationViewProtocol {
    func checkFormStatus() {
        if viewModel.isFormValid {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
}
