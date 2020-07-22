//
//  EmptyDataSource.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/20/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit
class EmptyDataSource: NSObject, TableViewDelegates {
    var message: String!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmptyCell = tableView.dequeueCell(for: indexPath)
        cell.configure(message)
        return cell
    }
}
