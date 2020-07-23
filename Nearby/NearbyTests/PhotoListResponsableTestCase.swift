//
//  PhotoListResponsableTestCase.swift
//  NearbyTests
//
//  Created by Mustafa Ezzat on 7/23/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import XCTest
@testable import Nearby

class PhotoListResponsableTestCase: XCTestCase {
    var sut: PhotoListResponsable!
     override func setUp() {
         super.setUp()
         // should init after super.setup()
         sut = PhotoListResponsable()
     }
     override func tearDown() {
         // should deinit before super.tearDown()
         sut = nil
         super.tearDown()
     }
    func test_ExploreResponsable_ResponseWithInvalidJSON() {
        let invalidJSON = Data("Invalid Json".utf8)
        sut.map(invalidJSON) { result in
            switch result {
            case .success(let response):
                XCTAssertNil(response)
            case .failure(let error):
                XCTAssertNotNil(error, "Invalid JSON")
            }
        }
    }
    func test_ExploreResponsable_ResponseWithEmptyJSON() {
        let emptyJSON = Data("{\"response\": {\"photos\": {\"items\": [] }}}".utf8)
        sut.map(emptyJSON) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }

}
