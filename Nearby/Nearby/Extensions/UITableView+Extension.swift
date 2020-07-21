//
//  UITableView+Extension.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)  as? T else {
            fatalError("init(nib:) has not been implemented")
        }
        return cell
    }
    func register<T: UITableViewCell>(cell: T.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    func register<T: UITableViewHeaderFooterView>(headerFooter: T.Type) {
        register(headerFooter.nib, forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
    }
}
