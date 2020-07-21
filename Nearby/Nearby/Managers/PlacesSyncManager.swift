//
//  PlacesSyncManager.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/21/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation

final class PlacesSyncManager {
    static let shared = PlacesSyncManager()
    var isRealTime: Bool!
    private init() {
        isRealTime = getRealTime()
        updateMode()
    }
    func setRealTime() {
        UserDefaults.standard.set(isRealTime, forKey: "NB_IsRealTime")
    }
    func getRealTime() -> Bool {
        guard let value = UserDefaults.standard.value(forKey: "NB_IsRealTime") as? Bool else {
            return true
        }
        return value
    }
    func updateMode() {
        if isRealTime {
            LocationManager.shared.setRealtimeUpdate()
        } else {
            LocationManager.shared.setSingleUpdate()
        }
    }
    @objc func toggleMode() {
        isRealTime = !isRealTime
        updateMode()
        setRealTime()
    }
}
