//
//  FetchPlacesWorker.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/18/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation
import FoursquareAPIClient

protocol PlaceFetcher {
    func fetchPlaces(with coordinate: LocationCoordinate, offset: Int, completionHandler: @escaping (Result<[Venue], Error>) -> Void)
}

class FoursquarePlaceFetcher: PlaceFetcher {
    func fetchPlaces(with coordinate: LocationCoordinate, offset: Int, completionHandler: @escaping (Result<[Venue], Error>) -> Void) {
        let client = FoursquareAPIClient(clientId: FourSquare.clientID, clientSecret: FourSquare.clientSecret)
        let explore = FourSquare.Explore.self
              let parameter = [
                  explore.coordinate: "\(coordinate.latitude),\(coordinate.longitude)",
                  explore.radius: "\(explore.radiusValue)",
                  explore.offset: "\(offset)",
                  explore.limit: "\(explore.limitValue)"
              ]
              client.request(path: explore.endPoint, parameter: parameter) { result in
                  switch result {
                  case let .success(data):
                    ExploreResponsable().map(data) { result in
                          switch result {
                          case .success(let response):
                                let venuList = (response.response.groups.first?.items ?? []).map { $0.venue }
                                completionHandler(.success(venuList))
                          case .failure(let error):
                                completionHandler(.failure(error))
                          }
                      }
                  case let .failure(error):
                    completionHandler(.failure(error))
                  }
              }
    }
}
