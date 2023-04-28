//
//  NewMessageViewController.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 27.04.2023.
//

import UIKit

protocol NewMessageViewControllerDelegate: AnyObject {
    func newMessageViewController(_ newMessageViewController: NewMessageViewController, withUser user: User)
}

final class NewMessageViewController: UIViewController {
    
    private let newMessageView = NewMessageView()
    public weak var delegate: NewMessageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        newMessageView.delegate = self
        view.addSubview(newMessageView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            newMessageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newMessageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            newMessageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            newMessageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func dismissController() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

}

extension NewMessageViewController: NewMessageViewDelegate {
    func dismissAndPresentChat(_ newMessageView: NewMessageView, withUser user: User) {
        delegate?.newMessageViewController(self, withUser: user)
    }
    func showError(_ newMessageView: NewMessageView, withError error: String) {
        presentError(error)
    }
}
