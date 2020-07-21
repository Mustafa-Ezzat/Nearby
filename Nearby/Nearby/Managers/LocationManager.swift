//
//  LocationManager.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/16/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerUpdate: class {
    func didUpdate(location: LocationCoordinate)
}

final class LocationManager: NSObject {
    static let shared = LocationManager()
    weak var delegate: LocationManagerUpdate!
    //location manager
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        _locationManager.activityType = . automotiveNavigation
        _locationManager.distanceFilter = Double(FourSquare.Explore.radiusValue / 2)  // Movement threshold for new events
        _locationManager.allowsBackgroundLocationUpdates = true // allow in background
        return _locationManager
    }()
    private override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
    }
    func setRealtimeUpdate() {
        locationManager.startUpdatingLocation()
    }
    func setSingleUpdate() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            manager.startUpdatingLocation() // start location manager
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        delegate.didUpdate(location: LocationCoordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
    }
}
