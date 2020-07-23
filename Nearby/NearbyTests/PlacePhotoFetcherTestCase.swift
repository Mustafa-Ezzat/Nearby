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
/*
     Venue Id =  4b0da1acf964a520b94c23e3
     Venue Id =  49fa1e2bf964a520c26d1fe3
     Venue Id =  54ed2379498edddc478a3e2f
     Venue Id =  54b40bc4498e15d8ea772bb4
     Venue Id =  4b85fca4f964a520a77c31e3
     Venue Id =  4a0a2772f964a5208a741fe3
     Venue Id =  584784192ec3640198cbff52
     Venue Id =  465c6e83f964a52033471fe3
     Venue Id =  4a24925df964a520317e1fe3
     Venue Id =  53669072498e86341f46bfb8
     Venue Id =  53927832498eb409d681e5fa
     Venue Id =  5721610a498e997b36ba960f
     Venue Id =  557cf8bb498e50ed073b435f
     Venue Id =  52250772498e6e13a93117bc
     Venue Id =  4b4c9641f964a520d8b626e3
     Venue Id =  55e8ff63498e0bee0d1d9824
     Venue Id =  59056e99a4b51b0b3e9d130f
     Venue Id =  54fb421c498eaf6bec3e5fbf
     Venue Id =  4a564aedf964a520f1b41fe3
     Venue Id =  4b23cbf4f964a520eb5924e3
     Venue Id =  4c771c53a5676dcb14e21721
     Venue Id =  429cfa80f964a520b6241fe3
     Venue Id =  5505e954498e9eb5c23cabcb
     Venue Id =  44c79850f964a520e6351fe3
     Venue Id =  50b92507b0b9d761acf3cfa3
     Venue Id =  4cfe75b347699eb03b621715

     */
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
