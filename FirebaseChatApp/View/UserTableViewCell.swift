//
//  UserTableViewCell.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import UIKit
import SDWebImage

final class UserTableViewCell: UITableViewCell {
    static let cellIdentifier = "UserTableViewCell"
    
    private let profileImageView: UIImageView = {
        let iView = UIImageView()
        iView.contentMode = .scaleAspectFill
        iView.clipsToBounds = true
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.layer.cornerRadius = 56/2
        return iView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Peter"
        label.textColor = .label
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Peter Parker"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        addSubviews(profileImageView, infoStack)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            profileImageView.heightAnchor.constraint(equalToConstant: 56),
            profileImageView.widthAnchor.constraint(equalToConstant: 56),
            
            infoStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoStack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
        ])
    }
    
    public func configure(with viewModel: UserTableViewCellViewModel) {
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        fullnameLabel.text = viewModel.fullname
        usernameLabel.text = viewModel.username
    }
}
