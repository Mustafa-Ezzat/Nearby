//
//  PlacePhotoFetcher.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/18/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation
import FoursquareAPIClient

protocol PlacePhotoFetcher {
    func fetchPlacePhotos(with id: String, completionHandler: @escaping (String?) -> Void)
}

class FoursquarePlacePhotoFetcher: PlacePhotoFetcher {
    func fetchPlacePhotos(with id: String, completionHandler: @escaping (String?) -> Void) {
        let client = FoursquareAPIClient(clientId: FourSquare.clientID, clientSecret: FourSquare.clientSecret)
        print("Venue Id = ", id)
        client.request(path: "venues/\(id)/photos", parameter: ["limit":"1"]) { result in
            switch result {
            case let .success(data):
                PhotoListResponsable().map(data) { result in
                    switch result {
                        case .success(let response):
                           let photoList = response.response.photos.items.map { $0.prefix + "\(88)" + $0.suffix }
                           completionHandler(photoList.first)
                        case .failure(_):
                           completionHandler(nil)
                    }
                }
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
}
