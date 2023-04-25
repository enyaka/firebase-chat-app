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
    
    private let textField: UITextField = {
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
        addSubviews(iconView, textField, dividerView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.leftAnchor.constraint(equalTo: leftAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            
            dividerView.leftAnchor.constraint(equalTo: leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: rightAnchor),
            dividerView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            dividerView.heightAnchor.constraint(equalToConstant: 1),

            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 10),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),

            
        ])
        
    }
}
