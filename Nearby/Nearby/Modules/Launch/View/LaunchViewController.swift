//
//  ViewController.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/20/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit

class LaunchViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    weak var coordinator: LaunchCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startExplore()
        hideNavigation()
        handleColorMode()
    }
    func handleColorMode() {
        titleLabel.textColor = .primary
    }

    func startExplore() {
        coordinator?.startExplore()
    }
}
