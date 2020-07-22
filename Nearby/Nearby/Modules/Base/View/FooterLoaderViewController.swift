//
//  FooterLoaderViewController.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/22/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit

typealias TableViewDelegates = UITableViewDataSource & UITableViewDelegate
class FooterLoaderViewController: BaseViewController {
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var placeTableView: UITableView!
    var emptyDataSource: EmptyDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func configurePlaceTableView(cellTypes: [UITableViewCell.Type]) {
        for type in cellTypes {
            placeTableView.register(cell: type)
        }
        emptyDataSource = EmptyDataSource()
        activityIndicator = UIActivityIndicatorView()
        placeTableView.tableFooterView = activityIndicator
    }
    func handleDatasource(_ dataSource: TableViewDelegates) {
        self.placeTableView.dataSource = dataSource
        self.placeTableView.delegate = dataSource
    }
    func handleEmptyDataSource(with message: String) {
        emptyDataSource.message = message
        handleDatasource(emptyDataSource)
        reloadTableView()
    }
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.placeTableView.reloadData()
            self.stopLoading()
        }
    }
    func startLoading() {
        self.activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(FourSquare.Explore.timeout)) { [weak self] in
            guard let self = self else { return }
            self.stopLoading()
        }
    }
    func stopLoading() {
        self.activityIndicator.stopAnimating()
    }
}
