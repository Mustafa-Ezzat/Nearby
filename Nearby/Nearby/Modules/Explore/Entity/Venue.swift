//
//  Venue.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/16/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation

struct Venue: Codable {
    let venueId: String
    let name: String
    let location: Location
    let photo: String?
    private enum CodingKeys: String, CodingKey {
        case venueId = "id"
        case name
        case location
        case photo
    }
}

struct Item: Codable {
    let venue: Venue
}
struct ItemList: Codable {
    let items: [Item]
}
struct GroupList: Codable {
    let groups: [ItemList]
}
struct ExploreResponse: Codable {
    let response: GroupList
}
struct ExploreResponsable: Responsable {
    typealias Model = ExploreResponse
    static let shared = ExploreResponsable()
    private init() {}
}
