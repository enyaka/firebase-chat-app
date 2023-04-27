//
//  AuthTextFieldView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

final class AuthTextFieldView: UIView {
    
    private let viewModel: AuthTextFieldViewViewModel
    
    private let iconView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.tintColor = .white
        iView.alpha = 0.87
        return iView
    }()
    
    public let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        return textField
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.87
        return view
    }()
    
    init(viewModel: AuthTextFieldViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureUI()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        iconView.image = viewModel.iconImage
        textField.attributedPlaceholder = viewModel.placeHolder
        textField.isSecureTextEntry = viewModel.isPassword
        addSubviews(iconView, textField, dividerView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            iconView.leftAnchor.constraint(equalTo: leftAnchor),
            iconView.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: -5),
            iconView.widthAnchor.constraint(equalToConstant: 25),
            
            dividerView.leftAnchor.constraint(equalTo: leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: rightAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),

            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 7),
            textField.rightAnchor.constraint(equalTo: rightAnchor),
            textField.bottomAnchor.constraint(equalTo: dividerView.topAnchor)

            
        ])
        
    }
}
