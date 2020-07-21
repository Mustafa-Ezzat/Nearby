//
//  ExploreInteractor.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation

protocol ExploreInteractorInput {
    func fetchPlaces(with coordinate: LocationCoordinate, offset: Int)
}

class ExploreInteractor {
    var presenter: ExplorePresenterInput?
    var placeFetcher: PlaceFetcher?
    var placePhotoFetcher: PlacePhotoFetcher?
    
    init() {
        placeFetcher = FoursquarePlaceFetcher()
        placePhotoFetcher = FoursquarePlacePhotoFetcher()
    }
    private func fetchPlacePhotos(_ list: [Venue]) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var venuPhotoList = [Venue]()
        list.forEach { venu in
            self.placePhotoFetcher?.fetchPlacePhotos(with: venu.venueId) { result in
                let venuModel = Venue(venueId: venu.venueId, name: venu.name, location: venu.location, photo: result)
                venuPhotoList.append(venuModel)
                if venuPhotoList.count == list.count { dispatchGroup.leave() }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.presenter?.present(list: venuPhotoList)
        }
    }
}

extension ExploreInteractor: ExploreInteractorInput {
    func fetchPlaces(with coordinate: LocationCoordinate, offset: Int) {
        placeFetcher?.fetchPlaces(with: coordinate, offset: offset) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let venuList):
                self.fetchPlacePhotos(venuList)
            case .failure(let error):
                self.presenter?.present(error: error)
            }
        }
    }
}
