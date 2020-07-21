//
//  ExploreCoordinator.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/18/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit

class ExploreCoordinator: Coordinator {
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    deinit {
        print("MovieSearchCoordinator deinit successfully...")
    }
    func start() {
        let view = ExploreViewController.instintiate()
        let presenter = ExplorePresenter()
        presenter.view = view
        let interactor = ExploreInteractor()
        interactor.presenter = presenter
        view.interactor = interactor
        self.navigationController.setViewControllers([view], animated: true)
    }
}
