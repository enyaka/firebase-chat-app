//
//  Extensions.swift
//  FirebaseChatApp
//
//  Created by Ensar Yasin Karaköse on 25.04.2023.
//

import UIKit
import JGProgressHUD


extension UIViewController {
//    static var errorAlert = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
    func configureGradientBackgroud() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    func presentError(_ message: String, title: String = "Error" , action: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: action, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension String {
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    /// Finds the current first responder
    /// - Returns: the current UIResponder if it exists
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
        throw NSError()
    }
    return dictionary
  }
}

extension UIView {
    static var hud = JGProgressHUD(style: .dark)
    func addSubviews(_ views: UIView...) {
           views.forEach({ addSubview($0) })
       }
    
    func handleLoader(_ show: Bool, withText text: String = "") {
        self.endEditing(true)
        UIView.hud.textLabel.text = text
        show ? UIView.hud.show(in: self) : UIView.hud.dismiss()
    }
    func getSafeAreaInsetBottom() -> CGFloat? {
        guard let window = UIApplication.shared.windows.first else { return nil}
        let bottomPadding = window.safeAreaInsets.bottom
        return bottomPadding
    }
    
    /*
     func anchor(top: NSLayoutYAxisAnchor? = nil,
                    left: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    right: NSLayoutXAxisAnchor? = nil,
                    paddingTop: CGFloat = 0,
                    paddingLeft: CGFloat = 0,
                    paddingBottom: CGFloat = 0,
                    paddingRight: CGFloat = 0,
                    width: CGFloat? = nil,
                    height: CGFloat? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }
            
            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }
            
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
            
            if let right = right {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
            
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
        func center(inView view: UIView, yConstant: CGFloat? = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
        }
        
        func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            if let topAnchor = topAnchor {
                self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
            }
        }
        
        func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
            
            if let leftAnchor = leftAnchor, let padding = paddingLeft {
                self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
            }
        }
        
        func setDimensions(width: CGFloat, height: CGFloat) {
            translatesAutoresizingMaskIntoConstraints = false
            widthAnchor.constraint(equalToConstant: width).isActive = true
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        func addConstraintsToFillView(_ view: UIView) {
            translatesAutoresizingMaskIntoConstraints = false
            anchor(top: view.topAnchor, left: view.leftAnchor,
                   bottom: view.bottomAnchor, right: view.rightAnchor)
        }
    */
}
