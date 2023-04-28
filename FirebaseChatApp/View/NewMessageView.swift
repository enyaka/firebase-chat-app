//
//  NewMessageView.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import UIKit

protocol NewMessageViewDelegate: AnyObject {
    func showError(_ newMessageView: NewMessageView, withError error: String)
    func dismissAndPresentChat(_ newMessageView: NewMessageView, withUser user: User)
}

final class NewMessageView: UIView {
    static let cellIdentifier = "NewMessageView"
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.cellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        return tableView
    }()
    
    public weak var delegate: NewMessageViewDelegate?
    private let viewModel = NewMessageViewViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addConstraints()
        bindToEventObserver()
        viewModel.fetchAllUsers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        addSubviews(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func bindToEventObserver() {
        viewModel.bindToCurrentEvent { [weak self] event in
            guard let self else { return }
            DispatchQueue.main.async {
                switch event {
                case .loading:
                    self.handleLoader(true, withText: "Loading")
                case .error(let error):
                    self.handleLoader(false)
                    self.delegate?.showError(self, withError: error)
                case .loaded:
                    self.handleLoader(false)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension NewMessageView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellIdentifier, for: indexPath) as? UserTableViewCell else { fatalError("Fatal Error: Casting cell") }
        cell.configure(with: UserTableViewCellViewModel(user: viewModel.users[indexPath.row]))
        return cell
    }
}

extension NewMessageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.dismissAndPresentChat(self, withUser: viewModel.users[indexPath.row])
    }
}


