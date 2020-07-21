//
//  ExplorePresenter.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation

typealias ExplorePresenterInput = ExplorePresenterProtocol & BasePresenterProtocol

protocol ExplorePresenterProtocol {
    func present(list: [Venue])
}

class ExplorePresenter {
    weak var view: ExploreViewInput?
}

extension ExplorePresenter: ExplorePresenterProtocol {
    func present(list: [Venue]) {
        guard list.count > 0 else {
            view?.display(error: "no places found")
            return
        }
        let placeList = list.map { Place(venuId: $0.venueId, name: $0.name, address: $0.location.address ?? "", photo: $0.photo ?? "") }
        view?.display(list: placeList)
    }
}
extension ExplorePresenter: BasePresenterProtocol {
    func present(error: Error) {
        view?.display(error: "something went wrong")
    }
}

