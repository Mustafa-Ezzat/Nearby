//
//  DataSource.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/16/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation

protocol DataSource {
    associatedtype Element
    var list: [Element] {get set}
}
