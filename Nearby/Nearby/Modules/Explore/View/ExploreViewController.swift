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
    func display(cashedPlaces: [Place])
}

class ExploreViewController: FooterLoaderViewController {
    var modeButton: UIBarButtonItem!
    var exploreDatasource: ExploreDatasource!
    var interactor: ExploreInteractorInput?
    var location: LocationCoordinate!
    var hasMorePlaces: Bool!
    var isRealTime: Bool!
    var offset: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        handleNavigationBar()
        configurePlaceTableView()
        synceLoacationUpdates()
    }
    func fetchPlaces() {
        guard let location = self.location, let interactor = self.interactor else {
            return
        }
        startLoading()
        interactor.fetchPlaces(with: location, offset: offset)
    }
    func synceLoacationUpdates() {
        LocationManager.shared.delegate = self
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
        super.configurePlaceTableView(cellTypes: [PlaceCell.self, EmptyCell.self])
        resetDataSource()
    }
    func resetDataSource() {
        offset = 0
        hasMorePlaces = true
        exploreDatasource = ExploreDatasource(list: [], view: self)
        handleDatasource(exploreDatasource)
    }
    func filterUniquePlaces() -> [Place] {
        guard let list = exploreDatasource?.list, !list.isEmpty else {
            return []
        }
        let uniqueList = Set<Place>(list)
        return Array(uniqueList)
    }
    override func startLoading() {
        guard offset > 0 else { return }
        super.startLoading()
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
        // offset: fetch places starting from
        offset += list.count
        exploreDatasource?.list.append(contentsOf: list)
        // view unique places
        exploreDatasource?.list = filterUniquePlaces()
        // cache last viewed places
        interactor?.cachePlaces(list: exploreDatasource?.list ?? [])
        handleDatasource(exploreDatasource)
        reloadTableView()
    }
    func display(cashedPlaces: [Place]) {
        hasMorePlaces = false
        exploreDatasource?.list = cashedPlaces
        handleDatasource(exploreDatasource)
        reloadTableView()
    }
    override func display(error: String) {
        handleEmptyDataSource(with: error)
    }
}
