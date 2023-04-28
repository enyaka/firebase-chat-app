//
//  ChatView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import UIKit

final class ChatView: UIView {
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
//    private lazy var textInputView: CostumInputView = {
//        let textView = CostumInputView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//        return textView
//    }()
    
    private lazy var deneme: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: self.frame.height, width: frame.width, height: 50))
        view.backgroundColor = .red
        return view
    }()
    
    private let viewModel: ChatViewViewModel
    
    init(viewModel: ChatViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureUI()
        addConstraints()
        addNotifications()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var inputAccessoryView: CostumInputView {
//        get {
//            return textInputView
//        }
//    }
//
//    override var canBecomeFirstResponder: Bool {
//        true
//    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .secondarySystemBackground
        addSubviews(collectionView, deneme)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        print(keyboardSize)

    }
    @objc func keyboardWillHide(notification: NSNotification) {}
}
