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
    func present(list: [Place])
    func present(cashedPlaces: [Place])
}

class ExplorePresenter {
    weak var view: ExploreViewInput?
    private func isEmptyPlaces(list: [Place]) -> Bool {
        guard list.count > 0 else {
            view?.display(error: "no places found")
            return true
        }
        return false
    }
}

extension ExplorePresenter: ExplorePresenterProtocol {
    func present(list: [Place]) {
        guard !isEmptyPlaces(list: list) else { return }
        view?.display(list: list)
    }
    func present(cashedPlaces: [Place]) {
        guard !isEmptyPlaces(list: cashedPlaces) else { return }
        view?.display(cashedPlaces: cashedPlaces)
    }
}
extension ExplorePresenter: BasePresenterProtocol {
    func present(error: Error) {
        view?.display(error: "Something went wrong")
    }
}
