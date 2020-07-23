//
//  Photo.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/18/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation
struct PhotoItem: Codable {
    let prefix: String
    let suffix: String
}
// The following models to decode the photos endpoint response JSON
struct PhotoItemList: Codable {
    let items: [PhotoItem]
}
struct PhotoList: Codable {
    let photos: PhotoItemList
}
struct PhotoListResponse: Codable {
    let response: PhotoList
}
struct PhotoListResponsable: Responsable {
    typealias Model = PhotoListResponse
}
