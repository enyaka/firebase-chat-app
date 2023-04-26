//
//  RegisterViewController.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit

final class RegisterViewController: UIViewController {

    private let registerView = RegisterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        configureGradientBackgroud()
        registerView.delegate = self
        view.addSubview(registerView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            registerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            registerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RegisterViewController: RegisterViewProtocol {
    
    func didSelectPhoto(_ registerView: RegisterView) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }

    func registerView(_ registerView: RegisterView) {
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        registerView.changePlusPhotoImage(image)
        dismiss(animated: true)
    }
}
