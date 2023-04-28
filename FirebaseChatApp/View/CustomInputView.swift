//
//  CustomInputView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import UIKit

final class CostumInputView: UIView {
    
    private let messageInputView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addConstraints()
        print("yeter")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    private func configureUI() {
//        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = .flexibleHeight
        backgroundColor = .red
        addSubviews(messageInputView, sendButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            messageInputView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            messageInputView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -8),
            messageInputView.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            messageInputView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            sendButton.heightAnchor.constraint(equalToConstant: 15),
            sendButton.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    @objc func sendTapped() {
        print("Send")
    }
}
