//
//  ExploreDatasource.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/20/20.
//  Copyright © 2020 foursquare. All rights reserved.
//
import UIKit

class ExploreDatasource: NSObject, DataSource {
    typealias Element = Place
    var list: [Place]
    weak var view: ExploreViewController?
    init(list: [Place], view: ExploreViewController) {
        self.list = list
        self.view = view
    }
}

extension ExploreDatasource: UITableViewDataSource {
    func validIndex(_ indexPath: IndexPath) -> Bool {
        guard indexPath.row < list.count  else {
            return false
        }
        return true
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlaceCell = tableView.dequeueCell(for: indexPath)
        if validIndex(indexPath) {
            let place = list[indexPath.row]
            cell.configure(place)
        }
        return cell
    }
}

extension ExploreDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let view = view, view.hasMorePlaces else {
            return
        }
        if indexPath.row == list.count - 1 {
            view.fetchPlaces()
        }
    }
}
