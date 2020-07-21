//
//  BaseViewController.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//
import UIKit

@objc protocol BaseViewProtocol: class {
    @objc func display(error: String)
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension BaseViewController: BaseViewProtocol {
    @objc func display(error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.showAlert(with: "", and: error)
        }
    }
}
