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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "deneme")
        collectionView.backgroundColor = .green
        return collectionView
    }()
    
    private let textInputView: CostumInputView = {
        let textView = CostumInputView()
        return textView
    }()
    //private var savedYPosition: Double?
    private let viewModel: ChatViewViewModel
    /// I am saving textInputView's bottom constraint because we want to update it when the keyboard shows up
    private var textInputViewBottomConstraint: NSLayoutConstraint?
    
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
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .secondarySystemBackground
        addSubviews(collectionView, textInputView)
    }
    
    private func addConstraints() {
        textInputViewBottomConstraint = NSLayoutConstraint(item: textInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        addConstraint(textInputViewBottomConstraint!)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: textInputView.topAnchor),

            textInputView.leftAnchor.constraint(equalTo: leftAnchor),
            textInputView.rightAnchor.constraint(equalTo: rightAnchor),
            textInputView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        /// Catches the keyboardWillShow notification and then updates to textInputViews bottom constraints
        /// - Returns: the current UIResponder if it exists
        guard let userInfo = notification.userInfo,
              let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let bottomConstraint = textInputViewBottomConstraint,
              /// When the keyboard shows up, there is a empty space shows up. It is caused by safeAreaLayoutGuied. Thats why i am calculating the safeAreas bottom height.
              let safeAreaBottomHeight = getSafeAreaInsetBottom() else {return}
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        /// I am updating textInputView's bottom constraint
        bottomConstraint.constant = -(keyboardFrame.height - safeAreaBottomHeight)
        layoutIfNeeded()
        
        /// Finds the current first responder
        /// - Returns: the current UIResponder if it exists
//        guard let userInfo = notification.userInfo,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
//              let currentTextFieldView = UIResponder.currentFirst() as? UITextField,
//              let inputViewsSuperView = currentTextFieldView.superview else { return }
//        print(frame.origin.y)
//        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//        let convertedTextFieldFrame = convert(inputViewsSuperView.frame, from: inputViewsSuperView.superview)
//        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
//
//        print("DEBUG: Keyboard Y : \(keyboardTopY)")
//        print("DEBUG: TextFieldBottom Y : \(textFieldBottomY)")
//
//        // if textField bottom is below keyboard bottom - bump the frame up
//        if textFieldBottomY > keyboardTopY {
////            frame.origin.y = -(keyboardTopY/2)
//            let textBoxY = convertedTextFieldFrame.origin.y
//            print("DEBUG: TextFieldBox Y : \(textBoxY)")
//            let newFrameY = (textFieldBottomY - keyboardTopY) * -1
//            print("DEBUG: New Frame Y : \(newFrameY)")
//            savedYPosition = frame.origin.y
//            frame.origin.y = newFrameY
//        }

        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let bottomConstraint = textInputViewBottomConstraint else {return}
        let keyboardFrame = keyboardFrameValue.cgRectValue
        /// In here when keyboard will hide, i am resetting textInputView's bottom constraint
        bottomConstraint.constant = 0
        layoutIfNeeded()
        
//        guard let yPosition = savedYPosition else { return }
//        frame.origin.y = yPosition
    }
}

extension ChatView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        110
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deneme", for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
    }
    
    
}

extension ChatView: UICollectionViewDelegate {
    
}
