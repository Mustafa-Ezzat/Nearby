//
//  UIViewController+Extension.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit
private var containerView: UIView!
extension UIViewController: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
protocol XIB {
    static func instintiate() -> Self
}
extension XIB where Self: UIViewController {
    static func instintiate() -> Self {
        return self.init(nibName: self.reuseIdentifier, bundle: nil)
    }
}
extension UIViewController: XIB {}
extension UIViewController {
    func hideNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    func showNavigation() {
        navigationController?.navigationBar.isHidden = false
    }
    func hideBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
