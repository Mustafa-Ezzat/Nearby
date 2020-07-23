//
//  PlacePhotoFetcherTestCase.swift
//  NearbyTests
//
//  Created by Mustafa Ezzat on 7/23/20.
//  Copyright © 2020 foursquare. All rights reserved.
//
import XCTest
@testable import Nearby

class PlacePhotoFetcherTestCase: XCTestCase {
    var sut: PlacePhotoFetcher!
      override func setUp() {
          super.setUp()
          // should init after super.setup()
          sut = FoursquarePlacePhotoFetcher()
      }
      override func tearDown() {
          // should deinit before super.tearDown()
          sut = nil
          super.tearDown()
      }

    func test_PlacePhotoFetcher_FetchPlacePhotos_WithValidVenueID() {
           let fetchPlacePhotoExp = expectation(description: "Wait for fetch completion ... ")
           sut.fetchPlacePhotos(with: "4b0da1acf964a520b94c23e3") { result in
               XCTAssertNotNil(result)
               fetchPlacePhotoExp.fulfill()
           }
           wait(for: [fetchPlacePhotoExp], timeout: 10.0)
    }
    func test_PlacePhotoFetcher_FetchPlacePhotos_WithInvalidVenueID() {
        let fetchPlacePhotoExp = expectation(description: "Wait for fetch completion ... ")
        sut.fetchPlacePhotos(with: "014149293934") { result in
            XCTAssertNil(result)
            fetchPlacePhotoExp.fulfill()
        }
        wait(for: [fetchPlacePhotoExp], timeout: 10.0)
    }
}
