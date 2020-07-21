//
//  Coordinator.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/16/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit

protocol Coordinator {
    // no need for childCoordinators in this release
    // var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController {get set}
    func start()
}
