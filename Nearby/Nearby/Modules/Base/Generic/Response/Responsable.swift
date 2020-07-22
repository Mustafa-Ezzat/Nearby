//
//  Responsable.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/17/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation
import FoursquareAPIClient

protocol Responsable {
    associatedtype Model
    func map(_ data: Data, completion: @escaping (Result<Model, Error>) -> Void)
}

extension Responsable where Model: Decodable {
    func map(_ data: Data, completion: @escaping (Result<Model, Error>) -> Void) {
        do {
            let decodableResponse = try JSONDecoder().decode(Model.self, from: data)
            completion(.success(decodableResponse))
        } catch {
            completion(.failure(error))
        }
    }
}
