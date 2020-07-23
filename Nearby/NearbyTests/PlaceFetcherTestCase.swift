//
//  FoursquarePlaceFetcherTestCase.swift
//  NearbyTests
//
//  Created by Mustafa Ezzat on 7/23/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import XCTest
@testable import Nearby

class PlaceFetcherTestCase: XCTestCase {
    var sut: PlaceFetcher!
    override func setUp() {
        super.setUp()
        // should init after super.setup()
        sut = FoursquarePlaceFetcher()
    }
    override func tearDown() {
        // should deinit before super.tearDown()
        sut = nil
        super.tearDown()
    }
    func test_PlaceFetcher_FetchPlaces_With_ValidCoordinate() {
        let fetchPlaceExp = expectation(description: "Wait for fetch completion ... ")
        sut.fetchPlaces(with: LocationCoordinate(latitude: Double(40.74224), longitude: Double(-73.99386)), offset: 0) { result in
            switch result {
            case .success(let placeList):
                XCTAssertNotNil(placeList, "")
            case .failure(let error):
                XCTAssertNil(error, "")
            }
            fetchPlaceExp.fulfill()
        }
        wait(for: [fetchPlaceExp], timeout: 10.0)
    }
    func test_PlaceFetcher_FetchPlaces_With_InvalidCoordinate() {
        let fetchPlaceExp = expectation(description: "Wait for fetch completion ... ")
        sut.fetchPlaces(with: LocationCoordinate(latitude: Double(0.0), longitude: Double(0.0)), offset: 0) { result in
            switch result {
            case .success(let placeList):
                XCTAssertNil(placeList, "")
            case .failure(let error):
                XCTAssertNotNil(error, "Invalid geo coordinates")
                print("error: ", error)
            }
            fetchPlaceExp.fulfill()
        }
        wait(for: [fetchPlaceExp], timeout: 10.0)
    }
}
