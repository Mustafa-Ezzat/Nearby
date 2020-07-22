//
//  RealmWorkerTestCase.swift
//  NearbyTests
//
//  Created by Mustafa Ezzat on 7/23/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import XCTest
import Unrealm
@testable import Nearby

class RealmWorkerTestCase: XCTestCase {
    var sut: RealmWorker!
    override func setUp() {
        super.setUp()
        // should init after super.setup()
        sut = RealmWorker()
        sut.clear()
        registerRealmables()
    }
    override func tearDown() {
        // should deinit before super.tearDown()
        sut = nil
        super.tearDown()
    }
    func registerRealmables() {
        Realm.registerRealmables(Place.self)
    }
    func write(places: [Place], completion: @escaping (Bool) -> Void) {
        sut.save(contentsOf: places) { result in
            completion(result)
        }
    }
    func test_RealmWorker_Write_EmpltyPlaces() {
        write(places: []) { result in
            XCTAssertTrue(result)
        }
    }
    func test_RealmWorker_fetch_EmpltyPlaces() {
        let list = sut.fetch(object: Place.self)
        XCTAssertEqual(list.all().count, 0)
    }
    func test_RealmWorker_fetch_Places() {
        let place = Place(venuId: "0c04582282944", name: "Down Town", address: "downtown 5th settlement", photo: "https://lal-storage.s3.amazonaws.com/cache.jpg")
        write(places: [place, place, place]) { [weak self] result in
            guard let self = self else { return }
            XCTAssertTrue(result)
            let list = self.sut.fetch(object: Place.self)
            XCTAssertEqual(list.all().count, 3)
        }
    }
    
    func testPerformance_Write_Places() {
          // This is an example of a performance test case.
          self.measure {
              // Put the code you want to measure the time of here.
            write(places: []) {_ in}
          }
    }
    func testPerformance_Fetch_Places() {
          self.measure {
              write(places: []) { [unowned self] _ in
                  _ = self.sut.fetch(object: Place.self)
              }
          }
      }
}
