//
//  ExploreViewController.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/18/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit

typealias ExploreViewInput = ExploreViewProtocol & BaseViewProtocol

protocol ExploreViewProtocol: class {
    func display(list: [Place])
}

class ExploreViewController: BaseViewController {
    @IBOutlet weak var placeTableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    var modeButton: UIBarButtonItem!
    var exploreDatasource: ExploreDatasource!
    var emptyDataSource: EmptyDataSource!
    var interactor: ExploreInteractorInput?
    var location: LocationCoordinate!
    var hasMorePlaces: Bool!
    var isRealTime: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        handleNavigationBar()
        configurePlaceTableView()
        LocationManager.shared.delegate = self
    }
    func fetchPlaces() {
        if !exploreDatasource.list.isEmpty { activityIndicator.startAnimating() }
        interactor?.fetchPlaces(with: location, offset: exploreDatasource.list.count)
    }
    func handleNavigationBar() {
        showNavigation()
        title = "Nearby"
        addModeButton()
    }
    func addModeButton() {
        modeButton = UIBarButtonItem(title: "Realtime", style: .plain, target: self, action: #selector(toggleMode))
        navigationItem.rightBarButtonItems = [modeButton]
        updateButtonTitle()
    }
    @objc func toggleMode() {
        PlacesSyncManager.shared.toggleMode()
        updateButtonTitle()
    }
    func updateButtonTitle() {
        modeButton.title = PlacesSyncManager.shared.isRealTime ? "Realtime" : "Single update"
    }
    func configurePlaceTableView() {
        emptyDataSource = EmptyDataSource()
        placeTableView.register(cell: PlaceCell.self)
        placeTableView.register(cell: EmptyCell.self)
        activityIndicator = UIActivityIndicatorView()
        placeTableView.tableFooterView = activityIndicator
        resetDataSource()
    }
    func resetDataSource() {
        hasMorePlaces = true
        exploreDatasource = ExploreDatasource(list: [], view: self)
        handleDatasource(exploreDatasource)
    }
    func handleDatasource(_ dataSource: TableViewDelegates) {
        self.placeTableView.dataSource = dataSource
        self.placeTableView.delegate = dataSource
    }
    func handleError(with message: String) {
        emptyDataSource.message = message
        handleDatasource(emptyDataSource)
        reloadTableView()
    }
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.placeTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}

extension ExploreViewController: LocationManagerUpdate {
    func didUpdate(location: LocationCoordinate) {
        guard self.location != location else {
            return
        }
        self.location = location
        resetDataSource()
        fetchPlaces()
    }
}

extension ExploreViewController: ExploreViewProtocol {
    func display(list: [Place]) {
        if list.count < FourSquare.Explore.limit {
            hasMorePlaces = false
        }
        exploreDatasource?.list.append(contentsOf: list)
        guard let places = exploreDatasource?.list, !places.isEmpty else {
            handleError(with: "No places found")
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.handleDatasource(self.exploreDatasource)
            self.reloadTableView()
        }
    }
    override func display(error: String) {
        handleError(with: "Something went wrong")
    }
}
