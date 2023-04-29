//
//  ChatView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import UIKit

final class ChatView: UIView {
    
    private let collectionView: UICollectionView = {
        let flowLayout = CommentFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CommentFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(ChatViewCell.self, forCellWithReuseIdentifier: ChatViewCell.cellIdentifier)
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
        addObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        textInputView.delegate = self
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
    
    private func addObservers() {
        viewModel.receiveMessage()
        viewModel.bindToMessages { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(row: self.viewModel.messages.count - 1, section: 0), at: .bottom, animated: true)
        }
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
        guard let bottomConstraint = textInputViewBottomConstraint else {return}
        /// In here when keyboard will hide, i am resetting textInputView's bottom constraint
        bottomConstraint.constant = 0
        layoutIfNeeded()
        
//        guard let yPosition = savedYPosition else { return }
//        frame.origin.y = yPosition
    }
}

extension ChatView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatViewCell.cellIdentifier, for: indexPath) as? ChatViewCell else { fatalError("Wrond cell identifier") }
        cell.configure(viewModel: .init(message: viewModel.messages[indexPath.row], profileImageUrl: viewModel.profileImageUrl))
        return cell
    }
}

extension ChatView: UICollectionViewDelegate {
    
}

extension ChatView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let mock = ChatViewCell()
//        mock.configure(viewModel: .init(message: viewModel.messages[indexPath.row], profileImageUrl: viewModel.profileImageUrl))
//        print(mock.frame.height)
////        let height = viewModel.messages[indexPath.row].text.height(withWidth: 250, font: .systemFont(ofSize: 16)) + 36
//        return .init(width: frame.width, height: mock.frame.height)
////        let frame = CGRect(x: 0, y: 0, width: frame.width, height: 50)
////        let estimatedCellSize = ChatViewCell(frame: frame)
////        estimatedCellSize.configure(viewModel: .init(message: viewModel.messages[indexPath.row], profileImageUrl: viewModel.profileImageUrl))
////        estimatedCellSize.layoutIfNeeded()
////        let targetSize = CGSize(width: frame.width, height: 1000)
////        let estimatedSize = estimatedCellSize.systemLayoutSizeFitting(targetSize)
////        return .init(width: frame.width, height: estimatedSize.height)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
//    }
}

extension ChatView: CostumInputViewDelegate {
    func inputView(_ costunInputView: CostumInputView, withMessage message: String) {
        viewModel.sendMessage(message)
    }
}
