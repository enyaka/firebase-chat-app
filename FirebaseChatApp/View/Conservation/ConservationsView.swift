//
//  ConservationsView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

protocol ConversationsViewProtocol: AnyObject {
    func newMessage(_ conversation: ConversationsView)
    func conversationsView(_ conversation: ConversationsView, withUser user: User)
}

final class ConversationsView: UIView {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ConservationTableViewCell.self, forCellReuseIdentifier: ConservationTableViewCell.cellIdentifier)
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private lazy var newMessageFloatingButton: UIButton = {
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
    private let viewModel: ConservationsViewViewModel = ConservationsViewViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addConstraints()
        addObservers()

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
    
    private func addObservers() {
        viewModel.bindToEvent { [weak self] event in
            guard let self else {return}
            switch event {
            case .loading:
                self.handleLoader(true, withText: "Loading")
            case .error(let string):
                self.handleLoader(false)
                print("DEBUG: Error \(string)")
            case .loaded:
                self.handleLoader(false)
                self.tableView.reloadData()
            }
        }
    }
    
    public func refreshConversations() {
        viewModel.conservations = []
        tableView.reloadData()
        viewModel.fetchConservations()
    }
    
    @objc func newMessageTapped() {
        delegate?.newMessage(self)
    }
    
}

extension ConversationsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.conservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConservationTableViewCell.cellIdentifier, for: indexPath) as? ConservationTableViewCell else { fatalError("Wrong cell identifier")}
        cell.configure(ConservationTableViewCellViewModel(conservation: viewModel.conservations[indexPath.row]))
        return cell
    }
}

extension ConversationsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = viewModel.conservations[indexPath.row].user
        delegate?.conversationsView(self, withUser: user)
    }
}
