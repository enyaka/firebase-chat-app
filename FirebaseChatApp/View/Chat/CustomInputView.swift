//
//  CustomInputView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import UIKit

protocol CostumInputViewDelegate: AnyObject {
    func inputView(_ costunInputView: CostumInputView, withMessage message: String)
}

final class CostumInputView: UIView {
    
    public let messageInputView: UITextField = {
        let textView = UITextField()
        textView.font = .systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.placeholder = "Enter message"
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .large)
        button.setImage(UIImage(systemName: "arrow.right.circle", withConfiguration: largeConfig), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 40 / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        return button
    }()
    
    public weak var delegate: CostumInputViewDelegate?

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
        backgroundColor = .systemBackground
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -10)
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        addSubviews(messageInputView, sendButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            messageInputView.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageInputView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            messageInputView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -10),
            
            sendButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func sendTapped() {
        guard let message = messageInputView.text,
              !message.isEmpty else { return }
        delegate?.inputView(self, withMessage: message)
        messageInputView.text = ""
    }
}
