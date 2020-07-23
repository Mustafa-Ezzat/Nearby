//
//  AppConstant.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation

enum FourSquare {
    static let clientID     = "WHL3YGEB4E54KEVCIPVN4TOZV5LDHO3DAJG1DGZGZLHQXJQ2"
    static let clientSecret = "KZQZ5VIN2KXD2LE15JG1XSYBMMIHM0JUPFKFT245Z4T1P0IN"
    enum Explore {
        static let endPoint = "venues/explore"
        static let radiusValue = 1000
        static let limitValue = 13
        static let timeout = 7
        // Params: Nesting Violation: Types should be nested at most 1 level deep (nesting)
        static let coordinate = "ll"
        static let radius = "radius"
        static let limit = "limit"
        static let offset = "offset"
    }
}
