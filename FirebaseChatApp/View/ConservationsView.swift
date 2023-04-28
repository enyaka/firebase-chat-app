//
//  ConservationsView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

protocol ConversationsViewProtocol: AnyObject {
    func newMessage(_ conservationView: ConversationsView)
}

final class ConversationsView: UIView {
    static let cellIdentifier = "tableviewcell"
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let newMessageFloatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.layer.cornerRadius = 56/2
        button.addTarget(self, action: #selector(newMessageTapped), for: .touchUpInside)
        return button
    }()
    
    public weak var delegate: ConversationsViewProtocol?
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        addSubviews(tableView, newMessageFloatingButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            newMessageFloatingButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            newMessageFloatingButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            newMessageFloatingButton.heightAnchor.constraint(equalToConstant: 56),
            newMessageFloatingButton.widthAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    @objc func newMessageTapped() {
        delegate?.newMessage(self)
    }
    
}

extension ConversationsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationsView.cellIdentifier, for: indexPath)
        cell.textLabel?.text = "Test cell"
        return cell
    }
}

extension ConversationsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
