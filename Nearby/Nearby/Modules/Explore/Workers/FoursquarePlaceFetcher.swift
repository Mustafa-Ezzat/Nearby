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
              let params = FourSquare.Explore.Params.self
              let parameter = [
                  params.ll : "\(coordinate.latitude),\(coordinate.longitude)",
                  params.radius : "\(FourSquare.Explore.radiusValue)",
                  params.offset: "\(offset)",
                  params.limit: "\(FourSquare.Explore.limit)"
              ];
              client.request(path: FourSquare.Explore.endPoint, parameter: parameter) { result in
                  switch result {
                  case let .success(data):
                      ExploreResponsable.shared.map(data) { result in
                          switch result {
                              case .success(let response):
                                  let venuList = (response.response.groups.first?.items ?? []).map { $0.venue }
                                  completionHandler(.success(venuList))
                              case .failure(let error):
                                  completionHandler(.failure(error))
                          }
                      }
                  case let .failure(error):
                    switch error {
                    case .connectionError:
                        // try to read from cashed
                        completionHandler(.failure(error))
                    default:
                        completionHandler(.failure(error))
                    }
                  }
              }
    }
}
