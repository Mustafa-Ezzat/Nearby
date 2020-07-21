//
//  LaunchCoordinator.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/20/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit

class LaunchCoordinator: Coordinator {
    var navigationController: UINavigationController
    var exploreCoordinator: ExploreCoordinator?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let launchViewController = LaunchViewController.instintiate()
        launchViewController.coordinator = self
        navigationController.pushViewController(launchViewController, animated: true)
    }
    func startExplore() {
        exploreCoordinator = ExploreCoordinator(navigationController: navigationController)
        exploreCoordinator?.start()
    }
}
