//
//  ConservationTableViewCell.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 6.05.2023.
//

import UIKit

final class ConservationTableViewCell: UITableViewCell {
    public static let cellIdentifier = "ConservationTableViewCell"
    
    private let profileImageView: UIImageView = {
        let iView = UIImageView()
        iView.contentMode = .scaleAspectFill
        iView.clipsToBounds = true
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.layer.cornerRadius = 50/2
        return iView
    }()
    
    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .tertiaryLabel
        label.text = "2h"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Peter"
        label.textColor = .label
        return label
    }()
    
    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Peter Parker"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()
    
    private var viewModel: ConservationTableViewCellViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func configureUI(){
        addSubviews(profileImageView, infoStack, timestampLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            
            infoStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoStack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            
            timestampLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            timestampLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),

        ])
    }
    
    public func configure(_ viewModel: ConservationTableViewCellViewModel) {
        self.viewModel = viewModel
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        usernameLabel.text = viewModel.username
        messageTextLabel.text = viewModel.message
        timestampLabel.text = viewModel.timestamp
    }

}
