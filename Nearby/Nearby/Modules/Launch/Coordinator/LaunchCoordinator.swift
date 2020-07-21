//
//  LaunchCoordinator.swift
//  Movielix
//
//  Created by Mustafa Ezzat on 5/7/20.
//  Copyright © 2020 Swvl. All rights reserved.
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