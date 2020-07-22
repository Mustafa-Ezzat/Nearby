//
//  Place.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/20/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation
import Unrealm

struct Place {
    let venuId: String
    let name: String
    let address: String
    let photo: String
}

extension Place: Hashable {
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.venuId == rhs.venuId || (lhs.name == rhs.name && lhs.address == rhs.address)
    }
}
extension Place: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.name < rhs.name
    }
}

extension Place: Realmable {
    init() {
        venuId = ""
        name = ""
        address = ""
        photo = ""
    }
}
