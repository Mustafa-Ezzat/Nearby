//
//  ExploreInteractor.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation
import FoursquareAPIClient

protocol ExploreInteractorInput {
    func fetchPlaces(with coordinate: LocationCoordinate, offset: Int)
    func cachePlaces(list: [Place])
}

class ExploreInteractor {
    var presenter: ExplorePresenterInput?
    var placeFetcher: PlaceFetcher?
    var placePhotoFetcher: PlacePhotoFetcher?
    var cacheWorker: CacheProtocol?
    
    init() {
        placeFetcher = FoursquarePlaceFetcher()
        placePhotoFetcher = FoursquarePlacePhotoFetcher()
        cacheWorker = RealmWorker()
    }
    private func fetchPlacePhotos(_ list: [Venue]) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var placeList = [Place]()
        list.forEach { venue in
            self.placePhotoFetcher?.fetchPlacePhotos(with: venue.venueId) { photoUrl in
                let place = Place(venuId: venue.venueId, name: venue.name, address: venue.location.address ?? "", photo: photoUrl ?? "")
                placeList.append(place)
                if placeList.count == list.count {
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.presenter?.present(list: placeList)
        }
    }
    private func fetchCachedPlaces() {
        let placeList = self.cacheWorker?.fetch(object: Place.self).all()
        self.presenter?.present(cashedPlaces: placeList ?? [])
    }
}

extension ExploreInteractor: ExploreInteractorInput {
    func cachePlaces(list: [Place]) {
        // cache here
        self.cacheWorker?.clear()
        self.cacheWorker?.save(contentsOf: list) {_ in}
    }

    func fetchPlaces(with coordinate: LocationCoordinate, offset: Int) {
        placeFetcher?.fetchPlaces(with: coordinate, offset: offset) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let venuList):
                self.fetchPlacePhotos(venuList)
            case .failure(let error):
                guard let fourSquareClientError = error as? FoursquareClientError else {
                    self.presenter?.present(error: error)
                    return
                }
                switch fourSquareClientError {
                case .connectionError:
                    // In case connection error: fetch cached places
                    self.fetchCachedPlaces()
                default:
                    self.presenter?.present(error: error)
                }
            }
        }
    }
}
