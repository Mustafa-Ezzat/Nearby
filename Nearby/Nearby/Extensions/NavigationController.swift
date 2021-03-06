//
//  NavigationController.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//
import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    private func configure() {
        navigationBar.tintColor = .primary
        if #available(iOS 12.0, *) {
            if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
                navigationBar.barTintColor = .black
                navigationBar.backgroundColor = .black
            }
        }
        var textAttributes = [NSAttributedString.Key: Any]()
        textAttributes[NSAttributedString.Key.foregroundColor] = UIColor.primary
        textAttributes[NSAttributedString.Key.font] = UIFont(fontStyle: .SFProDisplayBold, size: 24)
        navigationBar.titleTextAttributes = textAttributes
    }
}
