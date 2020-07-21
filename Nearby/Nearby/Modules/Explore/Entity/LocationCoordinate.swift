//
//  LocationCoordinate.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation

struct LocationCoordinate: Equatable {
    let latitude: Double
    let longitude: Double
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
