//
//  ChatViewCell.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 29.04.2023.
//

import UIKit

final class ChatViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ChatViewCell"
    
    private let profileImageView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.contentMode = .scaleAspectFill
        iView.clipsToBounds = true
        iView.backgroundColor = .secondaryLabel
        iView.layer.cornerRadius = 32 / 2
        return iView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .systemBackground
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    
    private var viewModel: ChatViewCellViewModel?
    private var bubbleViewLeftAnchor: NSLayoutConstraint?
    private var bubbleViewRightAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .red
        addSubviews(profileImageView, bubbleView)
        bubbleView.addSubview(textView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            profileImageView.heightAnchor.constraint(equalToConstant: 32),
            profileImageView.widthAnchor.constraint(equalToConstant: 32),
            
            bubbleView.topAnchor.constraint(equalTo: topAnchor),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),

            textView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 4),
            textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 12),
            textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -12),
            textView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -4),
        ])
        
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)

    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
            layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            return layoutAttributes
    }
    
    public func configure(viewModel: ChatViewCellViewModel) {
        self.viewModel = viewModel
        textView.text = viewModel.messageText
        bubbleView.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        profileImageView.isHidden = viewModel.shouldHideProfileImage
        bubbleViewLeftAnchor?.isActive = viewModel.leftAnchorActive
        bubbleViewRightAnchor?.isActive = viewModel.rightAnchorActive
        if !viewModel.shouldHideProfileImage { profileImageView.sd_setImage(with: viewModel.profileImageUrl) }
    }
}
